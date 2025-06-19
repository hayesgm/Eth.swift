//
//  EIP712.swift
//  Eth
//
//  EIP-712: Typed structured data hashing and signing
//  https://eips.ethereum.org/EIPS/eip-712
//

import Foundation
import SwiftKeccak
import SwiftNumber

extension ABI {
  public enum EIP712 {
    // MARK: - Core Types

    /// Represents EIP-712 typed data that can be signed
    public struct TypedData: Equatable, Sendable {
      public let domain: Domain
      public let types: [String: TypeDefinition]
      public let primaryType: String
      public let message: [String: Value]

      public init(
        domain: Domain,
        types: [String: TypeDefinition],
        primaryType: String,
        message: [String: Value]
      ) {
        self.domain = domain
        self.types = types
        self.primaryType = primaryType
        self.message = message
      }

      /// Encodes the typed data for signing (returns the full encoded message with 0x1901 prefix)
      public var encoded: Data {
        get throws {
          let domainSeparator = try domainSeparator()
          let messageHash = try hashStruct(typeName: primaryType, data: message)

          var result = Data()
          result.append(0x19)
          result.append(0x01)
          result.append(domainSeparator.data)
          result.append(messageHash.data)
          return result
        }
      }

      /// Returns the digest hash that should be signed (keccak256 of the encoded data)
      public var digest: Hex {
        get throws {
          Hex(SwiftKeccak.keccak256(try encoded))
        }
      }

      /// Returns all EIP-712 hash components separately
      /// - Returns: A tuple containing:
      ///   - domainSeparator: 32-byte keccak256 hash of the domain struct
      ///   - hashStruct: 32-byte keccak256 hash of the message struct
      ///   - digest: 32-byte keccak256 hash of the full encoded message (0x1901 || domainSeparator || hashStruct)
      public func components() throws -> (domainSeparator: Hex, hashStruct: Hex, digest: Hex) {
        let domainSep = try domainSeparator()  // Already returns keccak256 hash
        let messageHash = try hashStruct(typeName: primaryType, data: message)  // Already returns keccak256 hash
        let fullDigest = try digest

        return (domainSeparator: domainSep, hashStruct: messageHash, digest: fullDigest)
      }

      /// Returns the domain separator hash
      public func domainSeparator() throws -> Hex {
        let domainTypes = domain.domainType()
        let domainData = try domain.toValues()

        var allTypes = types
        allTypes["EIP712Domain"] = domainTypes

        return try Self.hashStruct(typeName: "EIP712Domain", data: domainData, types: allTypes)
      }

      /// Hashes a struct value according to EIP-712 spec
      public func hashStruct(typeName: String, data: [String: Value]) throws -> Hex {
        try Self.hashStruct(typeName: typeName, data: data, types: types)
      }

      /// Static version for internal use
      static func hashStruct(
        typeName: String,
        data: [String: Value],
        types: [String: TypeDefinition]
      ) throws -> Hex {
        guard let type = types[typeName] else {
          throw Error.missingType(typeName)
        }

        let encodedType = try encodeType(typeName, types: types)
        let typeHash = SwiftKeccak.keccak256(encodedType.data(using: .utf8)!)

        var encodedData = Data()
        encodedData.append(typeHash)

        for field in type.fields {
          guard let value = data[field.name] else {
            throw ABI.EIP712.Error.missingField(typeName: typeName, fieldName: field.name)
          }

          let encodedValue = try encodeValue(
            value: value,
            field: field,
            types: types
          )
          encodedData.append(encodedValue)
        }

        return Hex(SwiftKeccak.keccak256(encodedData))
      }

      /// Encodes a value for the given field according to EIP-712 rules
      static func encodeValue(
        value: Value,
        field: TypeDefinition.Field,
        types: [String: TypeDefinition]
      ) throws -> Data {
        // Check if it's a custom type
        if let customTypeName = field.customType {
          // For custom types, we expect a tuple value that matches the struct
          guard let customType = types[customTypeName] else {
            throw ABI.EIP712.Error.missingType(customTypeName)
          }

          // Extract values from the tuple
          guard case .tupleN(let values) = value,
            values.count == customType.fields.count
          else {
            throw ABI.EIP712.Error.invalidValue(type: customTypeName, value: value)
          }

          // Build the dictionary for recursive hashing
          var structData: [String: Value] = [:]
          for (index, structField) in customType.fields.enumerated() {
            structData[structField.name] = values[index]
          }

          return try hashStruct(typeName: customTypeName, data: structData, types: types).data
        }

        // Handle arrays
        if case .array(let elementSchema, let elements) = value {
          var encodedElements = Data()

          for element in elements {
            // Create a temporary field for the element
            let elementField = TypeDefinition.Field(
              name: "",
              type: elementSchema,
              customType: nil  // Arrays of custom types would use the schema
            )
            let encoded = try encodeValue(value: element, field: elementField, types: types)
            encodedElements.append(encoded)
          }

          return SwiftKeccak.keccak256(encodedElements)
        }

        // For primitive types, handle EIP-712 specific encoding
        switch field.type {
        case .string:
          guard case .string(let str) = value else {
            throw Error.invalidValue(type: "string", value: value)
          }
          return SwiftKeccak.keccak256(str.data(using: .utf8)!)

        case .bytes:
          guard case .bytes(let hex) = value else {
            throw Error.invalidValue(type: "bytes", value: value)
          }
          return SwiftKeccak.keccak256(hex.data)

        default:
          // For all other types (uint*, int*, address, bool, bytes*),
          // use standard ABI encoding which produces 32-byte values

          // Verify the value matches the expected schema
          guard value.schema == field.type else {
            throw Error.mismatchedValueType(
              expected: field.type.canonical, actual: value.schema.canonical)
          }

          let encoded = value.encoded

          // Verify we got exactly 32 bytes (all static types in EIP-712 are 32 bytes)
          guard encoded.data.count == 32 else {
            throw Error.invalidEncoding(
              "Expected 32 bytes for type \(field.type.canonical), got \(encoded.data.count)")
          }

          return encoded.data
        }
      }
    }

    /// EIP-712 domain parameters
    public struct Domain: Equatable, Sendable {
      public let name: String?
      public let version: String?
      public let chainId: UInt?
      public let verifyingContract: EthAddress?
      public let salt: Hex?  // 32 bytes

      public init(
        name: String? = nil,
        version: String? = nil,
        chainId: UInt? = nil,
        verifyingContract: EthAddress? = nil,
        salt: Hex? = nil
      ) {
        self.name = name
        self.version = version
        self.chainId = chainId
        self.verifyingContract = verifyingContract
        if let salt = salt {
          // Ensure salt is exactly 32 bytes
          if salt.data.count < 32 {
            self.salt = Hex(salt.data.leftPadded(to: 32))
          } else if salt.data.count > 32 {
            self.salt = Hex(salt.data.prefix(32))
          } else {
            self.salt = salt
          }
        } else {
          self.salt = nil
        }
      }

      /// Returns the EIP712Domain type definition based on which fields are present
      public func domainType() -> TypeDefinition {
        var fields: [TypeDefinition.Field] = []

        if name != nil {
          fields.append(.init(name: "name", type: .string))
        }
        if version != nil {
          fields.append(.init(name: "version", type: .string))
        }
        if chainId != nil {
          fields.append(.init(name: "chainId", type: .uint256))
        }
        if verifyingContract != nil {
          fields.append(.init(name: "verifyingContract", type: .address))
        }
        if salt != nil {
          fields.append(.init(name: "salt", type: .bytes32))
        }

        return TypeDefinition(fields: fields)
      }

      /// Convert domain to Value dictionary for hashing
      func toValues() throws -> [String: Value] {
        var result: [String: Value] = [:]

        if let name = name {
          result["name"] = .string(name)
        }
        if let version = version {
          result["version"] = .string(version)
        }
        if let chainId = chainId {
          result["chainId"] = .uint256(Number(chainId))
        }
        if let verifyingContract = verifyingContract {
          result["verifyingContract"] = .address(verifyingContract)
        }
        if let salt = salt {
          result["salt"] = .bytes32(salt)
        }

        return result
      }
    }

    /// Represents a custom type definition with fields
    public struct TypeDefinition: Equatable, Sendable {
      public let fields: [Field]

      public init(fields: [Field]) {
        self.fields = fields
      }

      public struct Field: Equatable, Sendable {
        public let name: String
        public let type: Schema
        public let customType: String?  // For referencing custom types

        public init(name: String, type: Schema, customType: String? = nil) {
          self.name = name
          self.type = type
          self.customType = customType
        }
      }
    }

    // MARK: - Type Encoding

    /// Encodes the type string per EIP-712 (e.g., "Mail(Person from,Person to,string contents)")
    public static func encodeType(
      _ typeName: String,
      types: [String: TypeDefinition]
    ) throws -> String {
      guard types[typeName] != nil else {
        throw Error.missingType(typeName)
      }

      var result = ""
      var processedTypes = Set<String>()
      var typesToProcess = [typeName]
      var referencedTypes: [String] = []

      // First, encode the primary type
      while let currentType = typesToProcess.first {
        typesToProcess.removeFirst()

        guard !processedTypes.contains(currentType) else {
          continue
        }

        guard let typeDefinition = types[currentType] else {
          throw Error.missingType(currentType)
        }

        // Build the type string
        let fieldStrings = typeDefinition.fields.map { field in
          let typeStr = field.customType ?? field.type.canonical
          return "\(typeStr) \(field.name)"
        }.joined(separator: ",")

        let encoded = "\(currentType)(\(fieldStrings))"

        if processedTypes.isEmpty {
          // This is the primary type
          result = encoded
        } else {
          // This is a referenced type, save it for later
          referencedTypes.append(encoded)
        }

        processedTypes.insert(currentType)

        // Find referenced custom types
        for field in typeDefinition.fields {
          if let customType = field.customType,
            !processedTypes.contains(customType)
          {
            typesToProcess.append(customType)
          }

          // Also check for custom types in arrays
          if case .array(let schema) = field.type,
            case .tuple(_) = schema,
            let arrayCustomType = field.customType?.replacingOccurrences(of: "[]", with: ""),
            !processedTypes.contains(arrayCustomType)
          {
            typesToProcess.append(arrayCustomType)
          }
        }
      }

      // Sort referenced types alphabetically and append them
      referencedTypes.sort()
      return result + referencedTypes.joined()
    }

    // MARK: - Errors

    public enum Error: Swift.Error, Equatable {
      case invalidDomain(String)
      case missingType(String)
      case missingField(typeName: String, fieldName: String)
      case invalidType(String)
      case unsupportedType(String)
      case encodingError(String)
      case invalidValue(type: String, value: Value)
      case mismatchedValueType(expected: String, actual: String)
      case invalidEncoding(String)
    }
  }
}

// MARK: - Data Extension

extension Data {
  func leftPadded(to size: Int) -> Data {
    if count >= size {
      return self
    }
    let padding = Data(repeating: 0, count: size - count)
    return padding + self
  }
}

// MARK: - Convenience Initializers

extension ABI.EIP712.TypedData {
  /// Initialize from a JSON string
  public init(jsonString: String) throws {
    let data = jsonString.data(using: .utf8)!
    try self.init(jsonData: data)
  }

  /// Initialize from JSON data
  public init(jsonData: Data) throws {
    let decoder = JSONDecoder()
    let decoded = try decoder.decode(CodableTypedData.self, from: jsonData)

    self.domain = decoded.domain
    self.primaryType = decoded.primaryType

    // Parse types from JSON representation
    self.types = try decoded.types.mapValues { jsonFields in
      let fields = try jsonFields.map { jsonField in
        try ABI.EIP712.TypeDefinition.Field(fromJSON: jsonField)
      }
      return ABI.EIP712.TypeDefinition(fields: fields)
    }

    // Convert the message based on the primary type
    guard let primaryTypeDef = types[primaryType] else {
      throw ABI.EIP712.Error.missingType(primaryType)
    }

    self.message = try Self.decodeMessage(
      decoded.message,
      typeDefinition: primaryTypeDef,
      types: types
    )
  }

  /// Convert to JSON data
  public func jsonData() throws -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

    // Convert types to JSON representation
    let jsonTypes = types.mapValues { typeDef in
      typeDef.fields.map { $0.toJSON() }
    }

    let codable = try CodableTypedData(
      domain: domain,
      types: jsonTypes,
      primaryType: primaryType,
      message: Self.encodeMessage(message, typeDefinition: types[primaryType]!, types: types)
    )

    return try encoder.encode(codable)
  }

  /// Convert to JSON string
  public func jsonString() throws -> String {
    String(data: try jsonData(), encoding: .utf8)!
  }
}

// MARK: - JSON Field Representation

private struct JSONField: Codable {
  let name: String
  let type: String
}

// MARK: - TypeDefinition.Field JSON Conversion

extension ABI.EIP712.TypeDefinition.Field {
  fileprivate init(fromJSON json: JSONField) throws {
    self.name = json.name

    // Parse the type string using the new Schema.fromCanonical
    let (schema, customType) = try ABI.Schema.fromCanonical(json.type)
    self.type = schema
    self.customType = customType
  }

  fileprivate func toJSON() -> JSONField {
    let typeString = customType ?? type.canonical
    return JSONField(name: name, type: typeString)
  }
}

// MARK: - Private Codable Wrapper

private struct CodableTypedData: Codable {
  let domain: ABI.EIP712.Domain
  let types: [String: [JSONField]]
  let primaryType: String
  let message: [String: Any?]

  enum CodingKeys: String, CodingKey {
    case domain, types, primaryType, message
  }

  init(
    domain: ABI.EIP712.Domain, types: [String: [JSONField]], primaryType: String,
    message: [String: Any?]
  ) {
    self.domain = domain
    self.types = types
    self.primaryType = primaryType
    self.message = message
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.domain = try container.decode(ABI.EIP712.Domain.self, forKey: .domain)
    self.types = try container.decode([String: [JSONField]].self, forKey: .types)
    self.primaryType = try container.decode(String.self, forKey: .primaryType)

    // Decode message as generic JSON
    let messageData = try container.decode(JSONValue.self, forKey: .message)
    guard let dict = messageData.objectValue else {
      throw DecodingError.dataCorruptedError(
        forKey: .message, in: container, debugDescription: "Message must be an object")
    }
    self.message = dict.mapValues { $0.value }
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(domain, forKey: .domain)
    try container.encode(types, forKey: .types)
    try container.encode(primaryType, forKey: .primaryType)
    try container.encode(JSONValue(message), forKey: .message)
  }
}

// MARK: - Message Conversion Helpers

extension ABI.EIP712.TypedData {
  fileprivate static func decodeMessage(
    _ dict: [String: Any?],
    typeDefinition: ABI.EIP712.TypeDefinition,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> [String: ABI.Value] {
    var result: [String: ABI.Value] = [:]

    for field in typeDefinition.fields {
      guard let value = dict[field.name] else {
        throw ABI.EIP712.Error.missingField(typeName: "message", fieldName: field.name)
      }

      result[field.name] = try decodeValue(value, field: field, types: types)
    }

    return result
  }

  fileprivate static func encodeMessage(
    _ values: [String: ABI.Value],
    typeDefinition: ABI.EIP712.TypeDefinition,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> [String: Any?] {
    var result: [String: Any?] = [:]

    for field in typeDefinition.fields {
      guard let value = values[field.name] else {
        throw ABI.EIP712.Error.missingField(typeName: "message", fieldName: field.name)
      }

      result[field.name] = try encodeValueToJSON(value, field: field, types: types)
    }

    return result
  }

  fileprivate static func decodeValue(
    _ value: Any?, field: ABI.EIP712.TypeDefinition.Field,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> ABI.Value {
    // Check if it's a custom type
    if let customTypeName = field.customType {
      // Handle arrays of custom types
      if customTypeName.hasSuffix("[]") {
        let elementTypeName = String(customTypeName.dropLast(2))
        guard let array = value as? [Any?],
          let elementType = types[elementTypeName]
        else {
          throw ABI.EIP712.Error.invalidValue(
            type: customTypeName, value: .string("\(value ?? "nil")"))
        }

        let elements = try array.map { element in
          try decodeCustomTypeValue(
            element, typeName: elementTypeName, typeDefinition: elementType, types: types)
        }

        // Return array with tuple schema (placeholder for custom types)
        return .array(.tuple([]), elements)
      } else {
        // Regular custom type
        guard let customType = types[customTypeName] else {
          throw ABI.EIP712.Error.missingType(customTypeName)
        }
        return try decodeCustomTypeValue(
          value, typeName: customTypeName, typeDefinition: customType, types: types)
      }
    }

    // Handle arrays of primitive types
    if case .array(let elementSchema) = field.type {
      guard let array = value as? [Any?] else {
        throw ABI.EIP712.Error.invalidValue(
          type: field.type.canonical, value: .string("\(value ?? "nil")"))
      }

      let elements = try array.map { element in
        try decodeBasicValue(element, schema: elementSchema)
      }

      return .array(elementSchema, elements)
    }

    // Handle primitive types
    return try decodeBasicValue(value, schema: field.type)
  }

  fileprivate static func decodeCustomTypeValue(
    _ value: Any?, typeName: String, typeDefinition: ABI.EIP712.TypeDefinition,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> ABI.Value {
    guard let dict = value as? [String: Any?] else {
      throw ABI.EIP712.Error.invalidValue(type: typeName, value: .string("\(value ?? "nil")"))
    }

    var values: [ABI.Value] = []
    for field in typeDefinition.fields {
      guard let fieldValue = dict[field.name] else {
        throw ABI.EIP712.Error.missingField(typeName: typeName, fieldName: field.name)
      }
      values.append(try decodeValue(fieldValue, field: field, types: types))
    }
    return .tupleN(values)
  }

  fileprivate static func encodeValueToJSON(
    _ value: ABI.Value, field: ABI.EIP712.TypeDefinition.Field,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> Any? {
    // Check if it's a custom type
    if let customTypeName = field.customType {
      // Handle arrays of custom types
      if customTypeName.hasSuffix("[]") {
        let elementTypeName = String(customTypeName.dropLast(2))
        guard case .array(_, let elements) = value,
          let elementType = types[elementTypeName]
        else {
          throw ABI.EIP712.Error.invalidValue(type: customTypeName, value: value)
        }

        return try elements.map { element in
          try encodeCustomTypeToJSON(
            element, typeName: elementTypeName, typeDefinition: elementType, types: types)
        }
      } else {
        // Regular custom type
        guard let customType = types[customTypeName] else {
          throw ABI.EIP712.Error.missingType(customTypeName)
        }
        return try encodeCustomTypeToJSON(
          value, typeName: customTypeName, typeDefinition: customType, types: types)
      }
    }

    // Handle arrays
    if case .array(_, let elements) = value {
      return try elements.map { element in
        try encodeBasicValueToJSON(element)
      }
    }

    // Handle primitive types
    return try encodeBasicValueToJSON(value)
  }

  fileprivate static func encodeCustomTypeToJSON(
    _ value: ABI.Value, typeName: String, typeDefinition: ABI.EIP712.TypeDefinition,
    types: [String: ABI.EIP712.TypeDefinition]
  ) throws -> Any? {
    guard case .tupleN(let values) = value else {
      throw ABI.EIP712.Error.invalidValue(type: typeName, value: value)
    }

    var dict: [String: Any?] = [:]
    for (index, field) in typeDefinition.fields.enumerated() {
      guard index < values.count else {
        throw ABI.EIP712.Error.invalidValue(type: typeName, value: value)
      }
      dict[field.name] = try encodeValueToJSON(values[index], field: field, types: types)
    }
    return dict
  }

  fileprivate static func decodeBasicValue(_ value: Any?, schema: ABI.Schema) throws -> ABI.Value {
    guard let value = value else {
      throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("nil"))
    }

    return try createValueFromJSON(value, schema: schema)
  }

  /// Helper method to create ABI.Value from JSON values based on schema
  fileprivate static func createValueFromJSON(_ jsonValue: Any, schema: ABI.Schema) throws
    -> ABI.Value
  {
    switch schema {
    case .address:
      guard let str = jsonValue as? String else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      let address = EthAddress(fromHexString: str)
      guard address != nil else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      return .address(address!)

    case .string:
      guard let str = jsonValue as? String else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      return .string(str)

    case .bytes:
      guard let str = jsonValue as? String else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      guard let hex = Hex(hex: str) else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      return .bytes(hex)

    case .bool:
      guard let bool = jsonValue as? Bool else {
        throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
      }
      return .bool(bool)

    // Handle all integer types through helpers
    case _ where schema.canonical.starts(with: "uint"):
      return try createUIntValue(from: jsonValue, schema: schema)

    case _ where schema.canonical.starts(with: "int"):
      return try createIntValue(from: jsonValue, schema: schema)

    case _ where schema.canonical.starts(with: "bytes") && schema != .bytes:
      return try createBytesNValue(from: jsonValue, schema: schema)

    default:
      throw ABI.EIP712.Error.unsupportedType(schema.canonical)
    }
  }

  /// Create uint value from JSON
  fileprivate static func createUIntValue(from jsonValue: Any, schema: ABI.Schema) throws
    -> ABI.Value
  {
    // First, extract the numeric value
    let number: Number
    if let u = jsonValue as? UInt {
      number = Number(u)
    } else if let i = jsonValue as? Int, i >= 0 {
      number = Number(i)
    } else if let d = jsonValue as? Double, d >= 0 {
      number = Number(Int(d))
    } else if let s = jsonValue as? String, let n = Number(s) {
      number = n
    } else {
      throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
    }

    // For small types that fit in UInt, check if we can use the more efficient representation
    switch schema {
    case .uint8, .uint16, .uint24, .uint32:
      if let uint = number.uInt {
        switch schema {
        case .uint8: return .uint8(uint)
        case .uint16: return .uint16(uint)
        case .uint24: return .uint24(uint)
        case .uint32: return .uint32(uint)
        default: break
        }
      }
    default:
      break
    }

    // For all uint types, create with Number
    switch schema {
    case .uint8: return .uint8(UInt(number))
    case .uint16: return .uint16(UInt(number))
    case .uint24: return .uint24(UInt(number))
    case .uint32: return .uint32(UInt(number))
    case .uint40: return .uint40(number)
    case .uint48: return .uint48(number)
    case .uint56: return .uint56(number)
    case .uint64: return .uint64(number)
    case .uint72: return .uint72(number)
    case .uint80: return .uint80(number)
    case .uint88: return .uint88(number)
    case .uint96: return .uint96(number)
    case .uint104: return .uint104(number)
    case .uint112: return .uint112(number)
    case .uint120: return .uint120(number)
    case .uint128: return .uint128(number)
    case .uint136: return .uint136(number)
    case .uint144: return .uint144(number)
    case .uint152: return .uint152(number)
    case .uint160: return .uint160(number)
    case .uint168: return .uint168(number)
    case .uint176: return .uint176(number)
    case .uint184: return .uint184(number)
    case .uint192: return .uint192(number)
    case .uint200: return .uint200(number)
    case .uint208: return .uint208(number)
    case .uint216: return .uint216(number)
    case .uint224: return .uint224(number)
    case .uint232: return .uint232(number)
    case .uint240: return .uint240(number)
    case .uint248: return .uint248(number)
    case .uint256: return .uint256(number)
    default:
      throw ABI.EIP712.Error.unsupportedType(schema.canonical)
    }
  }

  /// Create int value from JSON
  fileprivate static func createIntValue(from jsonValue: Any, schema: ABI.Schema) throws
    -> ABI.Value
  {
    // First, extract the numeric value
    let snumber: SNumber
    if let i = jsonValue as? Int {
      snumber = SNumber(i)
    } else if let d = jsonValue as? Double {
      snumber = SNumber(Int(d))
    } else if let s = jsonValue as? String, let n = SNumber(s) {
      snumber = n
    } else {
      throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
    }

    // For small types that fit in Int, check if we can use the more efficient representation
    switch schema {
    case .int8, .int16, .int24, .int32:
      if let int = snumber.int {
        switch schema {
        case .int8: return .int8(int)
        case .int16: return .int16(int)
        case .int24: return .int24(int)
        case .int32: return .int32(int)
        default: break
        }
      }
    default:
      break
    }

    // For all int types, create with SNumber
    switch schema {
    case .int8: return .int8(Int(snumber))
    case .int16: return .int16(Int(snumber))
    case .int24: return .int24(Int(snumber))
    case .int32: return .int32(Int(snumber))
    case .int40: return .int40(snumber)
    case .int48: return .int48(snumber)
    case .int56: return .int56(snumber)
    case .int64: return .int64(snumber)
    case .int72: return .int72(snumber)
    case .int80: return .int80(snumber)
    case .int88: return .int88(snumber)
    case .int96: return .int96(snumber)
    case .int104: return .int104(snumber)
    case .int112: return .int112(snumber)
    case .int120: return .int120(snumber)
    case .int128: return .int128(snumber)
    case .int136: return .int136(snumber)
    case .int144: return .int144(snumber)
    case .int152: return .int152(snumber)
    case .int160: return .int160(snumber)
    case .int168: return .int168(snumber)
    case .int176: return .int176(snumber)
    case .int184: return .int184(snumber)
    case .int192: return .int192(snumber)
    case .int200: return .int200(snumber)
    case .int208: return .int208(snumber)
    case .int216: return .int216(snumber)
    case .int224: return .int224(snumber)
    case .int232: return .int232(snumber)
    case .int240: return .int240(snumber)
    case .int248: return .int248(snumber)
    case .int256: return .int256(snumber)
    default:
      throw ABI.EIP712.Error.unsupportedType(schema.canonical)
    }
  }

  /// Create bytesN value from JSON
  fileprivate static func createBytesNValue(from jsonValue: Any, schema: ABI.Schema) throws
    -> ABI.Value
  {
    guard let str = jsonValue as? String else {
      throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string("\(jsonValue)"))
    }

    guard let hex = Hex(hex: str) else {
      throw ABI.EIP712.Error.invalidValue(type: schema.canonical, value: .string(str))
    }

    // Extract size from schema - we know it matches bytesN pattern
    let canonical = schema.canonical
    guard canonical.starts(with: "bytes"),
      let size = Int(canonical.dropFirst(5)),
      size > 0, size <= 32
    else {
      throw ABI.EIP712.Error.unsupportedType(canonical)
    }

    let paddedHex = Hex(hex.data.leftPadded(to: size))

    // Map size to the appropriate case
    switch size {
    case 1: return .bytes1(paddedHex)
    case 2: return .bytes2(paddedHex)
    case 3: return .bytes3(paddedHex)
    case 4: return .bytes4(paddedHex)
    case 5: return .bytes5(paddedHex)
    case 6: return .bytes6(paddedHex)
    case 7: return .bytes7(paddedHex)
    case 8: return .bytes8(paddedHex)
    case 9: return .bytes9(paddedHex)
    case 10: return .bytes10(paddedHex)
    case 11: return .bytes11(paddedHex)
    case 12: return .bytes12(paddedHex)
    case 13: return .bytes13(paddedHex)
    case 14: return .bytes14(paddedHex)
    case 15: return .bytes15(paddedHex)
    case 16: return .bytes16(paddedHex)
    case 17: return .bytes17(paddedHex)
    case 18: return .bytes18(paddedHex)
    case 19: return .bytes19(paddedHex)
    case 20: return .bytes20(paddedHex)
    case 21: return .bytes21(paddedHex)
    case 22: return .bytes22(paddedHex)
    case 23: return .bytes23(paddedHex)
    case 24: return .bytes24(paddedHex)
    case 25: return .bytes25(paddedHex)
    case 26: return .bytes26(paddedHex)
    case 27: return .bytes27(paddedHex)
    case 28: return .bytes28(paddedHex)
    case 29: return .bytes29(paddedHex)
    case 30: return .bytes30(paddedHex)
    case 31: return .bytes31(paddedHex)
    case 32: return .bytes32(paddedHex)
    default:
      throw ABI.EIP712.Error.unsupportedType(canonical)
    }
  }

  fileprivate static func encodeBasicValueToJSON(_ value: ABI.Value) throws -> Any? {
    switch value {
    case .address(let addr):
      return addr.hex
    case .string(let str):
      return str
    case .bytes(let hex):
      return hex.hex
    case .bool(let b):
      return b
    case let v where v.asUInt != nil:
      return v.asUInt!
    case let v where v.asNumber != nil:
      let num = v.asNumber!
      // Use the computed property from Number
      if let uint = num.uInt {
        return uint
      } else {
        // For large numbers, return as string to avoid JSON precision issues
        return num.description
      }
    case let v where v.asInt != nil:
      return v.asInt!
    case let v where v.asSNumber != nil:
      let snum = v.asSNumber!
      // Use the computed property from SNumber
      if let int = snum.int {
        return int
      } else {
        // For large numbers, return as string to avoid JSON precision issues
        return snum.description
      }
    case let v where v.asHex != nil:
      return v.asHex!.hex
    default:
      throw ABI.EIP712.Error.invalidValue(type: value.schema.canonical, value: value)
    }
  }
}

// MARK: - Domain Codable

extension ABI.EIP712.Domain: Codable {
  enum CodingKeys: String, CodingKey {
    case name, version, chainId, verifyingContract, salt
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.name = try container.decodeIfPresent(String.self, forKey: .name)
    self.version = try container.decodeIfPresent(String.self, forKey: .version)
    self.chainId = try container.decodeIfPresent(UInt.self, forKey: .chainId)

    if let contractStr = try container.decodeIfPresent(String.self, forKey: .verifyingContract) {
      self.verifyingContract = EthAddress(fromHexString: contractStr)
    } else {
      self.verifyingContract = nil
    }

    if let saltStr = try container.decodeIfPresent(String.self, forKey: .salt) {
      self.salt = Hex(hex: saltStr)
    } else {
      self.salt = nil
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encodeIfPresent(name, forKey: .name)
    try container.encodeIfPresent(version, forKey: .version)
    try container.encodeIfPresent(chainId, forKey: .chainId)
    try container.encodeIfPresent(verifyingContract?.hex, forKey: .verifyingContract)
    try container.encodeIfPresent(salt?.hex, forKey: .salt)
  }
}

// MARK: - TypeDefinition Codable

extension ABI.EIP712.TypeDefinition: Codable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.fields = try container.decode([Field].self)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(fields)
  }
}

extension ABI.EIP712.TypeDefinition.Field: Codable {
  enum CodingKeys: String, CodingKey {
    case name, type
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    self.name = try container.decode(String.self, forKey: .name)
    let typeString = try container.decode(String.self, forKey: .type)

    let (schema, customType) = try ABI.Schema.fromCanonical(typeString)
    self.type = schema
    self.customType = customType
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(name, forKey: .name)

    // Encode the canonical type string
    if let customType = customType {
      try container.encode(customType, forKey: .type)
    } else {
      try container.encode(type.canonical, forKey: .type)
    }
  }
}
