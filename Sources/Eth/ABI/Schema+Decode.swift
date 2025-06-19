//
//  Schema+Decode.swift
//  Eth
//
//  Extensions for decoding ABI.Schema from canonical string representations
//

import Foundation

extension ABI.Schema {
  /// Parse a canonical type string into an ABI.Schema
  /// - Parameter canonical: The canonical type string (e.g., "uint256", "address", "bytes32[]")
  /// - Returns: The corresponding ABI.Schema
  /// - Throws: ABI.EIP712.Error if the type cannot be parsed
  public static func fromCanonical(_ canonical: String) throws -> (
    schema: ABI.Schema, customType: String?
  ) {
    // Check if it's an array type
    if canonical.hasSuffix("[]") {
      let elementType = String(canonical.dropLast(2))
      let (elementSchema, elementCustom) = try fromCanonical(elementType)

      // For arrays of custom types, we return a placeholder schema
      if elementCustom != nil {
        return (.array(.tuple([])), canonical)  // Store full array type name
      } else {
        return (.array(elementSchema), nil)
      }
    }

    // Check for fixed-size arrays (e.g., "uint256[3]")
    if let bracketIndex = canonical.lastIndex(of: "["),
      let closeBracketIndex = canonical.lastIndex(of: "]"),
      bracketIndex < closeBracketIndex
    {
      let elementType = String(canonical[..<bracketIndex])
      let sizeStr = String(canonical[canonical.index(after: bracketIndex)..<closeBracketIndex])

      guard let size = Int(sizeStr), size > 0 else {
        throw ABI.EIP712.Error.unsupportedType(canonical)
      }

      let (elementSchema, elementCustom) = try fromCanonical(elementType)

      // For fixed arrays of custom types
      if elementCustom != nil {
        return (.arrayN(.tuple([]), size), canonical)
      } else {
        return (.arrayN(elementSchema, size), nil)
      }
    }

    // Try to parse as a primitive type
    switch canonical {
    case "address": return (.address, nil)
    case "bool": return (.bool, nil)
    case "string": return (.string, nil)
    case "bytes": return (.bytes, nil)

    case let t where t.starts(with: "uint"):
      let bits = String(t.dropFirst(4))
      guard let size = Int(bits), size > 0, size <= 256, size % 8 == 0 else {
        // Not a valid uint type, must be custom
        return (.tuple([]), canonical)
      }

      let schema: ABI.Schema = try uintSchema(bits: size)
      return (schema, nil)

    case let t where t.starts(with: "int"):
      let bits = String(t.dropFirst(3))
      guard let size = Int(bits), size > 0, size <= 256, size % 8 == 0 else {
        // Not a valid int type, must be custom
        return (.tuple([]), canonical)
      }

      let schema: ABI.Schema = try intSchema(bits: size)
      return (schema, nil)

    case let t where t.starts(with: "bytes") && t.count > 5:
      let sizeStr = String(t.dropFirst(5))
      guard let size = Int(sizeStr), size > 0, size <= 32 else {
        // Not a valid bytes type, must be custom
        return (.tuple([]), canonical)
      }

      let schema: ABI.Schema = try bytesNSchema(size: size)
      return (schema, nil)

    default:
      // It's a custom type - use tuple as a placeholder
      return (.tuple([]), canonical)
    }
  }

  /// Get the uint schema for a given bit size
  private static func uintSchema(bits: Int) throws -> ABI.Schema {
    switch bits {
    case 8: return .uint8
    case 16: return .uint16
    case 24: return .uint24
    case 32: return .uint32
    case 40: return .uint40
    case 48: return .uint48
    case 56: return .uint56
    case 64: return .uint64
    case 72: return .uint72
    case 80: return .uint80
    case 88: return .uint88
    case 96: return .uint96
    case 104: return .uint104
    case 112: return .uint112
    case 120: return .uint120
    case 128: return .uint128
    case 136: return .uint136
    case 144: return .uint144
    case 152: return .uint152
    case 160: return .uint160
    case 168: return .uint168
    case 176: return .uint176
    case 184: return .uint184
    case 192: return .uint192
    case 200: return .uint200
    case 208: return .uint208
    case 216: return .uint216
    case 224: return .uint224
    case 232: return .uint232
    case 240: return .uint240
    case 248: return .uint248
    case 256: return .uint256
    default: throw ABI.EIP712.Error.unsupportedType("uint\(bits)")
    }
  }

  /// Get the int schema for a given bit size
  private static func intSchema(bits: Int) throws -> ABI.Schema {
    switch bits {
    case 8: return .int8
    case 16: return .int16
    case 24: return .int24
    case 32: return .int32
    case 40: return .int40
    case 48: return .int48
    case 56: return .int56
    case 64: return .int64
    case 72: return .int72
    case 80: return .int80
    case 88: return .int88
    case 96: return .int96
    case 104: return .int104
    case 112: return .int112
    case 120: return .int120
    case 128: return .int128
    case 136: return .int136
    case 144: return .int144
    case 152: return .int152
    case 160: return .int160
    case 168: return .int168
    case 176: return .int176
    case 184: return .int184
    case 192: return .int192
    case 200: return .int200
    case 208: return .int208
    case 216: return .int216
    case 224: return .int224
    case 232: return .int232
    case 240: return .int240
    case 248: return .int248
    case 256: return .int256
    default: throw ABI.EIP712.Error.unsupportedType("int\(bits)")
    }
  }

  /// Get the bytesN schema for a given size
  private static func bytesNSchema(size: Int) throws -> ABI.Schema {
    switch size {
    case 1: return .bytes1
    case 2: return .bytes2
    case 3: return .bytes3
    case 4: return .bytes4
    case 5: return .bytes5
    case 6: return .bytes6
    case 7: return .bytes7
    case 8: return .bytes8
    case 9: return .bytes9
    case 10: return .bytes10
    case 11: return .bytes11
    case 12: return .bytes12
    case 13: return .bytes13
    case 14: return .bytes14
    case 15: return .bytes15
    case 16: return .bytes16
    case 17: return .bytes17
    case 18: return .bytes18
    case 19: return .bytes19
    case 20: return .bytes20
    case 21: return .bytes21
    case 22: return .bytes22
    case 23: return .bytes23
    case 24: return .bytes24
    case 25: return .bytes25
    case 26: return .bytes26
    case 27: return .bytes27
    case 28: return .bytes28
    case 29: return .bytes29
    case 30: return .bytes30
    case 31: return .bytes31
    case 32: return .bytes32
    default: throw ABI.EIP712.Error.unsupportedType("bytes\(size)")
    }
  }
}
