//
//  EIP712Tests.swift
//  EthTests
//
//  Tests for EIP-712 typed data encoding and hashing
//

import SwiftKeccak
import SwiftNumber
import Testing

@testable import Eth

@Suite("EIP-712 Tests")
struct EIP712Tests {

  // MARK: - Type Encoding Tests

  @Test("Encode type with nested dependencies")
  func encodeType() throws {
    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let encoded = try ABI.EIP712.encodeType("Mail", types: types)
    #expect(
      encoded == "Mail(Person from,Person to,string contents)Person(string name,address wallet)")
  }

  // MARK: - Hash Struct Tests

  @Test("Hash struct with nested custom types")
  func hashStruct() throws {
    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let value: [String: ABI.Value] = [
      "contents": .string("Hello, Bob!"),
      "from": .tupleN([
        .string("Cow"),
        .address(try EthAddress("0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826")),
      ]),
      "to": .tupleN([
        .string("Bob"),
        .address(try EthAddress("0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB")),
      ]),
    ]

    let hash = try ABI.EIP712.TypedData.hashStruct(typeName: "Mail", data: value, types: types)
    #expect(hash.hex == "0xc52c0ee5d84264471806290a3f2c4cecfc5490626bf912d01f240d7a274b371e")
  }

  // MARK: - Domain Separator Tests

  @Test("Domain separator with all fields")
  func domainSeparator() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC")
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let message: [String: ABI.Value] = [
      "contents": .string("Hello, Bob!"),
      "from": .tupleN([
        .string("Cow"),
        .address(try EthAddress("0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826")),
      ]),
      "to": .tupleN([
        .string("Bob"),
        .address(try EthAddress("0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB")),
      ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Mail",
      message: message
    )

    let separator = try typedData.domainSeparator()
    #expect(separator.hex == "0xf2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090f")
  }

  // MARK: - Components Test

  @Test("Get all EIP-712 components")
  func testComponents() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC")
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let message: [String: ABI.Value] = [
      "contents": .string("Hello, Bob!"),
      "from": .tupleN([
        .string("Cow"),
        .address(try EthAddress("0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826")),
      ]),
      "to": .tupleN([
        .string("Bob"),
        .address(try EthAddress("0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB")),
      ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Mail",
      message: message
    )

    let components = try typedData.components()

    // Verify domain separator
    #expect(
      components.domainSeparator.hex
        == "0xf2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090f")
    #expect(components.domainSeparator.data.count == 32)

    // Verify hash struct
    #expect(
      components.hashStruct.hex
        == "0xc52c0ee5d84264471806290a3f2c4cecfc5490626bf912d01f240d7a274b371e")
    #expect(components.hashStruct.data.count == 32)

    // Verify digest
    let expectedEncoded = try typedData.encoded
    let expectedDigest = Hex(SwiftKeccak.keccak256(expectedEncoded))
    #expect(components.digest == expectedDigest)
    #expect(components.digest.data.count == 32)

    // Also verify the digest property directly
    #expect(try typedData.digest == expectedDigest)
  }

  // MARK: - Full Encoding Tests

  @Test("Encode Mail example")
  func encodeMailExample() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC")
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let message: [String: ABI.Value] = [
      "contents": .string("Hello, Bob!"),
      "from": .tupleN([
        .string("Cow"),
        .address(try EthAddress("0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826")),
      ]),
      "to": .tupleN([
        .string("Bob"),
        .address(try EthAddress("0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB")),
      ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Mail",
      message: message
    )

    let encoded = try typedData.encoded
    #expect(
      Hex(encoded).hex
        == "0x1901f2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090fc52c0ee5d84264471806290a3f2c4cecfc5490626bf912d01f240d7a274b371e"
    )
  }

  @Test("Encode complex array")
  func encodeComplexArray() throws {
    let domain = ABI.EIP712.Domain(
      name: "Complex Array",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC")
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Array": .init(fields: [
        .init(name: "a", type: .uint256),
        .init(name: "b", type: .uint256),
        .init(name: "c", type: .string),
        .init(name: "d", type: .array(.bytes)),
      ])
    ]

    let message: [String: ABI.Value] = [
      "a": .uint256(Number(55)),
      "b": .uint256(Number(66)),
      "c": .string("Hello"),
      "d": .array(
        .bytes,
        [
          .bytes(try Hex("0x1122")),
          .bytes(try Hex("0x3344")),
        ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Array",
      message: message
    )

    let encoded = try typedData.encoded
    #expect(
      Hex(encoded).hex
        == "0x190103bd1627b4c5f7540c63d7ee347524dcef247eed29c833dd3b1455b8dec4009fcc95538bfc3f979ca59d9ef7de5ed402a4e403857b3de87d1fc8ed4a2a7cddd9"
    )
  }

  @Test("Encode with bool field")
  func encodeWithBool() throws {
    let domain = ABI.EIP712.Domain(
      name: "Complex Array",
      version: "1"
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Array": .init(fields: [
        .init(name: "a", type: .uint256),
        .init(name: "b", type: .uint256),
        .init(name: "c", type: .string),
        .init(name: "d", type: .bool),
      ])
    ]

    let message: [String: ABI.Value] = [
      "a": .uint256(Number(55)),
      "b": .uint256(Number(66)),
      "c": .string("Hello"),
      "d": .bool(true),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Array",
      message: message
    )

    let encoded = try typedData.encoded
    #expect(
      Hex(encoded).hex
        == "0x1901f4806c1a9dae718712eca4906bfca239a3a4a6dea2e9b9a1284fee5ff4df4b1c8c56315a01fe3937526fe8c2b472b7e9e1c21728f6c14d5ffb0e0c156f74aca0"
    )
  }

  @Test("Encode with minimal domain")
  func encodeMinimalDomain() throws {
    let domain = ABI.EIP712.Domain(
      name: "Complex Array",
      version: "1"
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Array": .init(fields: [
        .init(name: "a", type: .uint256),
        .init(name: "b", type: .uint256),
        .init(name: "c", type: .string),
        .init(name: "d", type: .array(.bytes)),
      ])
    ]

    let message: [String: ABI.Value] = [
      "a": .uint256(Number(55)),
      "b": .uint256(Number(66)),
      "c": .string("Hello"),
      "d": .array(
        .bytes,
        [
          .bytes(try Hex("0x1122")),
          .bytes(try Hex("0x3344")),
        ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Array",
      message: message
    )

    let encoded = try typedData.encoded
    #expect(
      Hex(encoded).hex
        == "0x1901f4806c1a9dae718712eca4906bfca239a3a4a6dea2e9b9a1284fee5ff4df4b1ccc95538bfc3f979ca59d9ef7de5ed402a4e403857b3de87d1fc8ed4a2a7cddd9"
    )
  }

  // MARK: - Domain Type Tests

  @Test("Domain type with all fields")
  func domainTypeWithAllFields() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"),
      salt: try Hex("0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef")
    )

    let domainType = domain.domainType()
    #expect(domainType.fields.count == 5)
    #expect(domainType.fields[0].name == "name")
    #expect(domainType.fields[0].type == .string)
    #expect(domainType.fields[1].name == "version")
    #expect(domainType.fields[1].type == .string)
    #expect(domainType.fields[2].name == "chainId")
    #expect(domainType.fields[2].type == .uint256)
    #expect(domainType.fields[3].name == "verifyingContract")
    #expect(domainType.fields[3].type == .address)
    #expect(domainType.fields[4].name == "salt")
    #expect(domainType.fields[4].type == .bytes32)
  }

  @Test("Domain type with partial fields")
  func domainTypePartialFields() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1"
    )

    let domainType = domain.domainType()
    #expect(domainType.fields.count == 2)
    #expect(domainType.fields[0].name == "name")
    #expect(domainType.fields[0].type == .string)
    #expect(domainType.fields[1].name == "version")
    #expect(domainType.fields[1].type == .string)
  }

  // MARK: - JSON Serialization Tests

  @Test("JSON deserialization")
  func jsonDeserialization() throws {
    let json = """
      {
        "domain": {
          "name": "Ether Mail",
          "version": "1",
          "chainId": 1,
          "verifyingContract": "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC"
        },
        "types": {
          "Person": [
            {
              "name": "name",
              "type": "string"
            },
            {
              "name": "wallet",
              "type": "address"
            }
          ],
          "Mail": [
            {
              "name": "from",
              "type": "Person"
            },
            {
              "name": "to",
              "type": "Person"
            },
            {
              "name": "contents",
              "type": "string"
            }
          ]
        },
        "primaryType": "Mail",
        "message": {
          "from": {
            "name": "Cow",
            "wallet": "0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826"
          },
          "to": {
            "name": "Bob",
            "wallet": "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"
          },
          "contents": "Hello, Bob!"
        }
      }
      """

    let typedData = try ABI.EIP712.TypedData(jsonString: json)

    // Verify domain
    #expect(typedData.domain.name == "Ether Mail")
    #expect(typedData.domain.version == "1")
    #expect(typedData.domain.chainId == 1)
    #expect(typedData.domain.verifyingContract?.hex == "0xcccccccccccccccccccccccccccccccccccccccc")

    // Verify types
    #expect(typedData.types.count == 2)
    #expect(typedData.types["Person"]?.fields.count == 2)
    #expect(typedData.types["Mail"]?.fields.count == 3)

    // Verify primary type
    #expect(typedData.primaryType == "Mail")

    // Verify message
    #expect(typedData.message["contents"]?.asString == "Hello, Bob!")

    // Verify encoding matches expected
    let encoded = try typedData.encoded
    #expect(
      Hex(encoded).hex
        == "0x1901f2cee375fa42b42143804025fc449deafd50cc031ca257e0b194a650a912090fc52c0ee5d84264471806290a3f2c4cecfc5490626bf912d01f240d7a274b371e"
    )
  }

  @Test("JSON round-trip serialization")
  func jsonSerialization() throws {
    let domain = ABI.EIP712.Domain(
      name: "Ether Mail",
      version: "1",
      chainId: 1,
      verifyingContract: try EthAddress("0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC")
    )

    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Mail": .init(fields: [
        .init(name: "from", type: .tuple([]), customType: "Person"),
        .init(name: "to", type: .tuple([]), customType: "Person"),
        .init(name: "contents", type: .string),
      ]),
      "Person": .init(fields: [
        .init(name: "name", type: .string),
        .init(name: "wallet", type: .address),
      ]),
    ]

    let message: [String: ABI.Value] = [
      "contents": .string("Hello, Bob!"),
      "from": .tupleN([
        .string("Cow"),
        .address(try EthAddress("0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826")),
      ]),
      "to": .tupleN([
        .string("Bob"),
        .address(try EthAddress("0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB")),
      ]),
    ]

    let typedData = ABI.EIP712.TypedData(
      domain: domain,
      types: types,
      primaryType: "Mail",
      message: message
    )

    // Serialize to JSON and back
    let jsonData = try typedData.jsonData()
    let deserialized = try ABI.EIP712.TypedData(jsonData: jsonData)

    // Verify they produce the same encoding
    let originalEncoded = try typedData.encoded
    let deserializedEncoded = try deserialized.encoded
    #expect(Hex(originalEncoded) == Hex(deserializedEncoded))
  }

  // MARK: - Type Value Encoding Tests

  @Test("Encode address value")
  func encodeDataValueAddress() throws {
    let value = ABI.Value.address(try EthAddress("0x0000000000000000000000000000000000000001"))
    let field = ABI.EIP712.TypeDefinition.Field(name: "addr", type: .address)
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    #expect(encoded.count == 32)
    #expect(
      Hex(encoded) == Hex("0x0000000000000000000000000000000000000000000000000000000000000001"))
  }

  @Test("Encode uint256 value")
  func encodeDataValueUInt() throws {
    let value = ABI.Value.uint256(Number(55))
    let field = ABI.EIP712.TypeDefinition.Field(name: "num", type: .uint256)
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    #expect(encoded.count == 32)
    #expect(Hex(encoded).hex.suffix(2) == "37")  // 55 in hex
  }

  @Test("Encode bytes32 value")
  func encodeDataValueBytes32() throws {
    let value = ABI.Value.bytes32(try Hex("0xCC"))
    let field = ABI.EIP712.TypeDefinition.Field(name: "data", type: .bytes32)
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    #expect(encoded.count == 32)
    #expect(Hex(encoded).hex.prefix(4) == "0xcc")
  }

  @Test("Encode bool values")
  func encodeDataValueBool() throws {
    let valueTrue = ABI.Value.bool(true)
    let field = ABI.EIP712.TypeDefinition.Field(name: "flag", type: .bool)
    let encodedTrue = try ABI.EIP712.TypedData.encodeValue(
      value: valueTrue, field: field, types: [:])

    #expect(encodedTrue.count == 32)
    #expect(Hex(encodedTrue).hex.suffix(2) == "01")

    let valueFalse = ABI.Value.bool(false)
    let encodedFalse = try ABI.EIP712.TypedData.encodeValue(
      value: valueFalse, field: field, types: [:])

    #expect(encodedFalse.count == 32)
    #expect(Hex(encodedFalse).hex.suffix(2) == "00")
  }

  @Test("Encode string value")
  func encodeDataValueString() throws {
    let value = ABI.Value.string("Cow")
    let field = ABI.EIP712.TypeDefinition.Field(name: "name", type: .string)
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    let expected = Hex(SwiftKeccak.keccak256("Cow".data(using: .utf8)!))
    #expect(Hex(encoded) == expected)
  }

  @Test("Encode dynamic bytes value")
  func encodeDataValueBytes() throws {
    let value = ABI.Value.bytes(try Hex("0xCCDD"))
    let field = ABI.EIP712.TypeDefinition.Field(name: "data", type: .bytes)
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    let expected = try Hex("0x9014B850703629D30F5C8C6C86A6AD981AB9319997490629D7DA37E8CAE985A1")
    #expect(Hex(encoded) == expected)
  }

  @Test("Encode array value")
  func encodeDataValueArray() throws {
    let value = ABI.Value.array(
      .bytes,
      [
        .bytes(try Hex("0xCCDD")),
        .bytes(try Hex("0xEE")),
      ])
    let field = ABI.EIP712.TypeDefinition.Field(name: "data", type: .array(.bytes))
    let encoded = try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])

    let expected = try Hex("0x134619415A3C9FE841D99F7CFD5C0BCCFC7CF0DAE90743A3D717C748A3961CF5")
    #expect(Hex(encoded) == expected)
  }

  // MARK: - Schema Parsing Tests

  @Test("Parse canonical type strings")
  func schemaFromCanonical() throws {
    // Basic types
    let (addressSchema, addressCustom) = try ABI.Schema.fromCanonical("address")
    #expect(addressSchema == .address)
    #expect(addressCustom == nil)

    let (uint256Schema, uint256Custom) = try ABI.Schema.fromCanonical("uint256")
    #expect(uint256Schema == .uint256)
    #expect(uint256Custom == nil)

    let (bytes32Schema, bytes32Custom) = try ABI.Schema.fromCanonical("bytes32")
    #expect(bytes32Schema == .bytes32)
    #expect(bytes32Custom == nil)

    // Array types
    let (arraySchema, arrayCustom) = try ABI.Schema.fromCanonical("uint256[]")
    #expect(arraySchema == .array(.uint256))
    #expect(arrayCustom == nil)

    // Custom types
    let (customSchema, customType) = try ABI.Schema.fromCanonical("Person")
    #expect(customSchema == .tuple([]))
    #expect(customType == "Person")

    // Custom array types
    let (customArraySchema, customArrayType) = try ABI.Schema.fromCanonical("Person[]")
    #expect(customArraySchema == .array(.tuple([])))
    #expect(customArrayType == "Person[]")
  }

  // MARK: - Error Cases

  @Test("Missing type error")
  func missingType() throws {
    let types: [String: ABI.EIP712.TypeDefinition] = [:]

    #expect(throws: ABI.EIP712.Error.missingType("NonExistent")) {
      try ABI.EIP712.encodeType("NonExistent", types: types)
    }
  }

  @Test("Missing field error")
  func missingField() throws {
    let types: [String: ABI.EIP712.TypeDefinition] = [
      "Test": .init(fields: [
        .init(name: "field1", type: .string)
      ])
    ]

    let value: [String: ABI.Value] = [:]  // Missing field1

    #expect(throws: ABI.EIP712.Error.missingField(typeName: "Test", fieldName: "field1")) {
      try ABI.EIP712.TypedData.hashStruct(typeName: "Test", data: value, types: types)
    }
  }

  @Test("Mismatched value type error")
  func invalidValueType() throws {
    let value = ABI.Value.string("not an address")
    let field = ABI.EIP712.TypeDefinition.Field(name: "addr", type: .address)

    #expect(throws: ABI.EIP712.Error.mismatchedValueType(expected: "address", actual: "string")) {
      try ABI.EIP712.TypedData.encodeValue(value: value, field: field, types: [:])
    }
  }
}
