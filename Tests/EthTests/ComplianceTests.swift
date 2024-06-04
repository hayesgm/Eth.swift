import BigInt
@testable import Eth
import XCTest

struct ComplianceTest: Decodable {
    let name: String
    let bytecode: Data
    let query: Data
    let expResp: Data
    let expSuccess: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case bytecode
        case query
        case expResp
        case expSuccess
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)

        func decodeHex(forKey key: CodingKeys) throws -> Data {
            let hexString = try container.decode(String.self, forKey: key)
            guard let data = Hex.parseHex(hexString) else {
                throw DecodingError.dataCorruptedError(forKey: key, in: container, debugDescription: "Invalid hex string")
            }
            return data
        }

        bytecode = try decodeHex(forKey: .bytecode)
        query = try decodeHex(forKey: .query)
        expResp = try decodeHex(forKey: .expResp)
        expSuccess = try container.decode(Bool.self, forKey: .expSuccess)
    }
}

final class ComplianceTests: XCTestCase {
    func testRunComplianceTests() throws {
        // Load all tests from `Tests/ComplianceJson/*.json` as a `ComplianceTest` struct
        let directoryPath = "./Tests/ComplianceJson/"
        let fileManager = FileManager.default
        var complianceTests: [ComplianceTest] = []

        // Get all JSON files in the directory
        if let enumerator = fileManager.enumerator(atPath: directoryPath) {
            for case let file as String in enumerator {
                if file.hasSuffix(".json") {
                    let filePath = "\(directoryPath)\(file)"
                    if let data = fileManager.contents(atPath: filePath) {
                        let decoder = JSONDecoder()
                        let test = try! decoder.decode(ComplianceTest.self, from: data)
                        complianceTests.append(test)
                    }
                }
            }
        }

        for test in complianceTests {
            let resp: Data = try EVM.runQuery(bytecode: test.bytecode, query: test.query)
            XCTAssertEqual(Hex.toHex(resp), Hex.toHex(test.expResp), test.name)
        }
    }
}
