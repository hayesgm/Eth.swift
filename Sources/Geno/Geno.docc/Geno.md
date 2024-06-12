
# ``Geno``

Geno is code generator of swift wrappers to Solidity contracts.

## Getting Started

Geno generates Swift code that wraps the usage of Solidity contracts in type-safe Swift. This makes it easy to call and use Solidity contracts in Swift with compile-time guarantees.

First, make sure you have a Solidity ABI json file. For instance, you can use [forge](https://book.getfoundry.sh/) to build a Solidity project into the `out/` directory. Then, you can simply run:

```sh
swift run Geno ./out/Cool.sol/Cool.json --outDir Sources/
```

It's also suggested you run [swiftformat](https://github.com/nicklockwood/SwiftFormat) on the generated file.

## Examples

Let's say you have a Solidity file as such:

```js
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Cool {
    function sum(uint256 x, uint256 y) pure external returns (uint256) {
        return x + y;
    }
}
```

The output from `Geno` should look something like this:

```swift
import BigInt
import Eth
import Foundation

enum Cool {
    static let creationCode: Hex = "0x..."
    static let runtimeCode: Hex = "0x..."

    static let sumFn = ABI.Function(
        name: "sum",
        inputs: [.uint256, .uint256],
        outputs: [.uint256]
    )

    static func sum(x: BigUInt, y: BigUInt) throws -> BigUInt {
        let query = try sumFn.encoded(with: [.uint256(x), .uint256(y)])
        let result = try EVM.runQuery(bytecode: runtimeCode, query: query)
        let decoded = try sumFn.decode(output: result)

        switch decoded {
        case let .tuple1(.uint256(var0)):
            return var0
        default:
            throw ABI.DecodeError.mismatchedType(decoded.schema, sumFn.outputTuple)
        }
    }
}
```

From there, you can start to call into the real functionality of the contract. E.g. to run the `sum` function locally, you can run:

```swift
> try Cool.sum(x: BigUInt(1000), y: BigUInt(1000))
BigUInt(2000)
```
