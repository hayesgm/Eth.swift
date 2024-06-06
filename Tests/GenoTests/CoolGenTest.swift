import XCTest

final class CoolGenTests: XCTestCase {
    func testDecodeContract() {
        //Generated Cool Works
        let cool = Cool.init()
        
        // Assert ABI
        XCTAssertEqual(cool.abi.count, 2)
        XCTAssertEqual(cool.abi[0].name, "callsInternal")
        XCTAssertEqual(cool.abi[1].name, "callsLibrary")

        // Assert Bytecode
        XCTAssertEqual(cool.bytecode.object, "0x608060405234801561001057600080fd5b50610191806100206000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80631b9275bb1461003b578063a7942a4c14610060575b600080fd5b61004e610049366004610102565b610073565b60405190815260200160405180910390f35b61004e61006e366004610102565b6100a1565b6000610088610083836001610131565b6100bf565b610091836100bf565b61009b9190610131565b92915050565b60006100b66100b1836001610131565b6100d6565b610091836100ed565b60006100cb8280610144565b61009b906001610131565b6000600a8211156100e95750600a919050565b5090565b60006100f8826100d6565b61009b9083610144565b60006020828403121561011457600080fd5b5035919050565b634e487b7160e01b600052601160045260246000fd5b8082018082111561009b5761009b61011b565b808202811582820484141761009b5761009b61011b56fea26469706673582212201417553ab6412bf684106571a631c5a72cdfb30352ea043359882e501d99f38064736f6c63430008180033")
    }
}
