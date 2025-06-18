//
//  JSONValue.swift
//  Eth
//
//  A type-safe representation of JSON values
//

import Foundation

/// A type-safe representation of JSON values
public enum JSONValue: Codable, Equatable, Sendable {
  case string(String)
  case number(Double)
  case bool(Bool)
  case array([JSONValue])
  case object([String: JSONValue])
  case null

  /// Initialize from any value, attempting to convert it to the appropriate JSON type
  public init(_ value: Any?) {
    guard let value = value else {
      self = .null
      return
    }

    switch value {
    case let str as String:
      self = .string(str)
    case let num as Double:
      self = .number(num)
    case let num as Float:
      self = .number(Double(num))
    case let num as Int:
      self = .number(Double(num))
    case let num as UInt:
      self = .number(Double(num))
    case let num as Int8:
      self = .number(Double(num))
    case let num as UInt8:
      self = .number(Double(num))
    case let num as Int16:
      self = .number(Double(num))
    case let num as UInt16:
      self = .number(Double(num))
    case let num as Int32:
      self = .number(Double(num))
    case let num as UInt32:
      self = .number(Double(num))
    case let num as Int64:
      self = .number(Double(num))
    case let num as UInt64:
      self = .number(Double(num))
    case let bool as Bool:
      self = .bool(bool)
    case let array as [Any]:
      self = .array(array.map { JSONValue($0) })
    case let array as [Any?]:
      self = .array(array.map { JSONValue($0) })
    case let dict as [String: Any]:
      self = .object(dict.mapValues { JSONValue($0) })
    case let dict as [String: Any?]:
      self = .object(dict.mapValues { JSONValue($0) })
    case is NSNull:
      self = .null
    default:
      // For unknown types, convert to string representation
      self = .string("\(value)")
    }
  }

  /// Get the underlying value as `Any?`
  public var value: Any? {
    switch self {
    case .string(let str): return str
    case .number(let num): return num
    case .bool(let bool): return bool
    case .array(let arr): return arr.map { $0.value }
    case .object(let obj): return obj.mapValues { $0.value }
    case .null: return nil
    }
  }

  // MARK: - Codable

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()

    if container.decodeNil() {
      self = .null
    } else if let bool = try? container.decode(Bool.self) {
      self = .bool(bool)
    } else if let number = try? container.decode(Double.self) {
      self = .number(number)
    } else if let string = try? container.decode(String.self) {
      self = .string(string)
    } else if let array = try? container.decode([JSONValue].self) {
      self = .array(array)
    } else if let object = try? container.decode([String: JSONValue].self) {
      self = .object(object)
    } else {
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Could not decode JSONValue"
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    switch self {
    case .null:
      try container.encodeNil()
    case .bool(let value):
      try container.encode(value)
    case .number(let value):
      try container.encode(value)
    case .string(let value):
      try container.encode(value)
    case .array(let array):
      try container.encode(array)
    case .object(let object):
      try container.encode(object)
    }
  }

  // MARK: - Convenience Accessors

  /// Returns the value as a String if it is a string, otherwise nil
  public var stringValue: String? {
    guard case .string(let value) = self else { return nil }
    return value
  }

  /// Returns the value as a Double if it is a number, otherwise nil
  public var numberValue: Double? {
    guard case .number(let value) = self else { return nil }
    return value
  }

  /// Returns the value as an Int if it is a number that can be exactly represented as Int, otherwise nil
  public var intValue: Int? {
    guard case .number(let value) = self else { return nil }
    let int = Int(value)
    // Check if conversion is lossless
    guard Double(int) == value else { return nil }
    return int
  }

  /// Returns the value as a UInt if it is a number that can be exactly represented as UInt, otherwise nil
  public var uintValue: UInt? {
    guard case .number(let value) = self,
      value >= 0
    else { return nil }
    let uint = UInt(value)
    // Check if conversion is lossless
    guard Double(uint) == value else { return nil }
    return uint
  }

  /// Returns the value as a Bool if it is a boolean, otherwise nil
  public var boolValue: Bool? {
    guard case .bool(let value) = self else { return nil }
    return value
  }

  /// Returns the value as an array if it is an array, otherwise nil
  public var arrayValue: [JSONValue]? {
    guard case .array(let value) = self else { return nil }
    return value
  }

  /// Returns the value as an object if it is an object, otherwise nil
  public var objectValue: [String: JSONValue]? {
    guard case .object(let value) = self else { return nil }
    return value
  }

  /// Returns true if this is null
  public var isNull: Bool {
    guard case .null = self else { return false }
    return true
  }

  // MARK: - Subscript Support

  /// Access array elements by index
  public subscript(index: Int) -> JSONValue? {
    guard case .array(let arr) = self,
      index >= 0,
      index < arr.count
    else { return nil }
    return arr[index]
  }

  /// Access object values by key
  public subscript(key: String) -> JSONValue? {
    guard case .object(let obj) = self else { return nil }
    return obj[key]
  }
}
