import XCTest
import SwiftNumber
@testable import Eth

final class TupleSizeTests: XCTestCase {
    
    // Test encoding and decoding for all tuple sizes
    func testAllTupleSizes() throws {
        // Test tuple0
        let tuple0 = ABI.Value.tuple0
        XCTAssertEqual(tuple0.encoded, Hex("0x"))
        XCTAssertEqual(try ABI.Schema.tuple([]).decode(tuple0.encoded), tuple0)
        
        // Test tuple1
        let tuple1 = ABI.Value.tuple1(.uint256(Number(1)))
        XCTAssertEqual(tuple1.asArray?.count, 1)
        XCTAssertEqual(try ABI.Schema.tuple([.uint256]).decode(tuple1.encoded), tuple1)
        
        // Test tuple2
        let tuple2 = ABI.Value.tuple2(.uint256(Number(1)), .uint256(Number(2)))
        XCTAssertEqual(tuple2.asArray?.count, 2)
        XCTAssertEqual(try ABI.Schema.tuple([.uint256, .uint256]).decode(tuple2.encoded), tuple2)
        
        // Test tuple3
        let tuple3 = ABI.Value.tuple3(.uint256(Number(1)), .uint256(Number(2)), .uint256(Number(3)))
        XCTAssertEqual(tuple3.asArray?.count, 3)
        XCTAssertEqual(try ABI.Schema.tuple([.uint256, .uint256, .uint256]).decode(tuple3.encoded), tuple3)
        
        // Test tuple4
        let tuple4 = ABI.Value.tuple4(.uint256(Number(1)), .uint256(Number(2)), .uint256(Number(3)), .uint256(Number(4)))
        XCTAssertEqual(tuple4.asArray?.count, 4)
        XCTAssertEqual(try ABI.Schema.tuple([.uint256, .uint256, .uint256, .uint256]).decode(tuple4.encoded), tuple4)
        
        // Test tuple5
        let tuple5 = ABI.Value.tuple5(.uint256(Number(1)), .uint256(Number(2)), .uint256(Number(3)), .uint256(Number(4)), .uint256(Number(5)))
        XCTAssertEqual(tuple5.asArray?.count, 5)
        XCTAssertEqual(try ABI.Schema.tuple([.uint256, .uint256, .uint256, .uint256, .uint256]).decode(tuple5.encoded), tuple5)
        
        // Test tuple10
        let values10 = (1...10).map { ABI.Value.uint256(Number($0)) }
        let tuple10 = ABI.Value.tuple10(
            values10[0], values10[1], values10[2], values10[3], values10[4],
            values10[5], values10[6], values10[7], values10[8], values10[9]
        )
        XCTAssertEqual(tuple10.asArray?.count, 10)
        let schemas10 = Array(repeating: ABI.Schema.uint256, count: 10)
        XCTAssertEqual(try ABI.Schema.tuple(schemas10).decode(tuple10.encoded), tuple10)
        
        // Test tuple15
        let values15 = (1...15).map { ABI.Value.uint256(Number($0)) }
        let tuple15 = ABI.Value.tuple15(
            values15[0], values15[1], values15[2], values15[3], values15[4],
            values15[5], values15[6], values15[7], values15[8], values15[9],
            values15[10], values15[11], values15[12], values15[13], values15[14]
        )
        XCTAssertEqual(tuple15.asArray?.count, 15)
        let schemas15 = Array(repeating: ABI.Schema.uint256, count: 15)
        XCTAssertEqual(try ABI.Schema.tuple(schemas15).decode(tuple15.encoded), tuple15)
        
        // Test tuple20
        let values20 = (1...20).map { ABI.Value.uint256(Number($0)) }
        let tuple20 = ABI.Value.tuple20(
            values20[0], values20[1], values20[2], values20[3], values20[4],
            values20[5], values20[6], values20[7], values20[8], values20[9],
            values20[10], values20[11], values20[12], values20[13], values20[14],
            values20[15], values20[16], values20[17], values20[18], values20[19]
        )
        XCTAssertEqual(tuple20.asArray?.count, 20)
        let schemas20 = Array(repeating: ABI.Schema.uint256, count: 20)
        XCTAssertEqual(try ABI.Schema.tuple(schemas20).decode(tuple20.encoded), tuple20)
        
        // Test tuple25
        let values25 = (1...25).map { ABI.Value.uint256(Number($0)) }
        let tuple25 = ABI.Value.tuple25(
            values25[0], values25[1], values25[2], values25[3], values25[4],
            values25[5], values25[6], values25[7], values25[8], values25[9],
            values25[10], values25[11], values25[12], values25[13], values25[14],
            values25[15], values25[16], values25[17], values25[18], values25[19],
            values25[20], values25[21], values25[22], values25[23], values25[24]
        )
        XCTAssertEqual(tuple25.asArray?.count, 25)
        let schemas25 = Array(repeating: ABI.Schema.uint256, count: 25)
        XCTAssertEqual(try ABI.Schema.tuple(schemas25).decode(tuple25.encoded), tuple25)
        
        // Test tuple30
        let values30 = (1...30).map { ABI.Value.uint256(Number($0)) }
        let tuple30 = ABI.Value.tuple30(
            values30[0], values30[1], values30[2], values30[3], values30[4],
            values30[5], values30[6], values30[7], values30[8], values30[9],
            values30[10], values30[11], values30[12], values30[13], values30[14],
            values30[15], values30[16], values30[17], values30[18], values30[19],
            values30[20], values30[21], values30[22], values30[23], values30[24],
            values30[25], values30[26], values30[27], values30[28], values30[29]
        )
        XCTAssertEqual(tuple30.asArray?.count, 30)
        let schemas30 = Array(repeating: ABI.Schema.uint256, count: 30)
        XCTAssertEqual(try ABI.Schema.tuple(schemas30).decode(tuple30.encoded), tuple30)
        
        // Test tuple40
        let values40 = (1...40).map { ABI.Value.uint256(Number($0)) }
        let tuple40 = ABI.Value.tuple40(
            values40[0], values40[1], values40[2], values40[3], values40[4],
            values40[5], values40[6], values40[7], values40[8], values40[9],
            values40[10], values40[11], values40[12], values40[13], values40[14],
            values40[15], values40[16], values40[17], values40[18], values40[19],
            values40[20], values40[21], values40[22], values40[23], values40[24],
            values40[25], values40[26], values40[27], values40[28], values40[29],
            values40[30], values40[31], values40[32], values40[33], values40[34],
            values40[35], values40[36], values40[37], values40[38], values40[39]
        )
        XCTAssertEqual(tuple40.asArray?.count, 40)
        let schemas40 = Array(repeating: ABI.Schema.uint256, count: 40)
        XCTAssertEqual(try ABI.Schema.tuple(schemas40).decode(tuple40.encoded), tuple40)
        
        // Test tuple50
        let values50 = (1...50).map { ABI.Value.uint256(Number($0)) }
        let tuple50 = ABI.Value.tuple50(
            values50[0], values50[1], values50[2], values50[3], values50[4],
            values50[5], values50[6], values50[7], values50[8], values50[9],
            values50[10], values50[11], values50[12], values50[13], values50[14],
            values50[15], values50[16], values50[17], values50[18], values50[19],
            values50[20], values50[21], values50[22], values50[23], values50[24],
            values50[25], values50[26], values50[27], values50[28], values50[29],
            values50[30], values50[31], values50[32], values50[33], values50[34],
            values50[35], values50[36], values50[37], values50[38], values50[39],
            values50[40], values50[41], values50[42], values50[43], values50[44],
            values50[45], values50[46], values50[47], values50[48], values50[49]
        )
        XCTAssertEqual(tuple50.asArray?.count, 50)
        let schemas50 = Array(repeating: ABI.Schema.uint256, count: 50)
        XCTAssertEqual(try ABI.Schema.tuple(schemas50).decode(tuple50.encoded), tuple50)
    }
    
    // Test tupleFromValues for all sizes
    func testTupleFromValues() throws {
        // Test sizes 0 through 50
        for size in 0...50 {
            let values: [ABI.Value]
            if size == 0 {
                values = []
            } else {
                values = (1...size).map { ABI.Value.uint256(Number($0)) }
            }
            let tuple = ABI.Value.tupleFromValues(values)
            XCTAssertEqual(tuple.asArray?.count, size)
            
            // Verify it encodes and decodes properly
            let schemas = Array(repeating: ABI.Schema.uint256, count: size)
            let decoded = try ABI.Schema.tuple(schemas).decode(tuple.encoded)
            XCTAssertEqual(decoded, tuple)
        }
        
        // Test size 51 (should use tupleN)
        let values51 = (1...51).map { ABI.Value.uint256(Number($0)) }
        let tuple51 = ABI.Value.tupleFromValues(values51)
        if case .tupleN(let vals) = tuple51 {
            XCTAssertEqual(vals.count, 51)
        } else {
            XCTFail("Expected tupleN for 51 values")
        }
    }
    
    // Test edge cases with mixed types
    func testMixedTypeTuples() throws {
        // Test tuple32 with mixed types
        let tuple32 = ABI.Value.tuple32(
            .uint8(1), .uint16(2), .uint32(3), .uint64(Number(4)), .uint128(Number(5)),
            .int8(6), .int16(7), .int32(8), .int64(SNumber(9)), .int128(SNumber(10)),
            .bool(true), .bool(false), .address(EthAddress(fromHexString: "0x0000000000000000000000000000000000000000")!), .string("hello"), .bytes(Hex("0x1234")),
            .bytes1(Hex("0x11")), .bytes2(Hex("0x1122")), .bytes4(Hex("0x11223344")), .bytes8(Hex("0x1122334455667788")), .bytes16(Hex("0x11223344556677889900112233445566")),
            .bytes32(Hex("0x1122334455667788990011223344556677889900112233445566778899001122")),
            .array(.uint8, [.uint8(1), .uint8(2)]), .arrayN(.uint8, 3, [.uint8(1), .uint8(2), .uint8(3)]),
            .tuple0, .tuple1(.uint8(99)), .tuple2(.uint8(100), .uint8(101)),
            .uint256(Number(27)), .uint256(Number(28)), .uint256(Number(29)), .uint256(Number(30)),
            .uint256(Number(31)), .uint256(Number(32))
        )
        
        XCTAssertEqual(tuple32.asArray?.count, 32)
        XCTAssertNotNil(tuple32.encoded)
        XCTAssertNotNil(tuple32.description)
        XCTAssertNotNil(tuple32.jsonValue)
    }
    
    // Test conversion between tupleNN and tupleN
    func testTupleConversions() throws {
        // Test that tupleNN cases can be converted to tupleN and back
        let values = (1...35).map { ABI.Value.uint256(Number($0)) }
        let tuple35 = ABI.Value.tuple35(
            values[0], values[1], values[2], values[3], values[4],
            values[5], values[6], values[7], values[8], values[9],
            values[10], values[11], values[12], values[13], values[14],
            values[15], values[16], values[17], values[18], values[19],
            values[20], values[21], values[22], values[23], values[24],
            values[25], values[26], values[27], values[28], values[29],
            values[30], values[31], values[32], values[33], values[34]
        )
        
        // Convert to tupleN
        let tupleN = tuple35.asTupleN!
        if case .tupleN(let vals) = tupleN {
            XCTAssertEqual(vals.count, 35)
            XCTAssertEqual(vals, values)
        } else {
            XCTFail("Expected tupleN")
        }
        
        // Convert back using tupleFromValues
        let reconstructed = ABI.Value.tupleFromValues(values)
        XCTAssertEqual(reconstructed, tuple35)
    }
}