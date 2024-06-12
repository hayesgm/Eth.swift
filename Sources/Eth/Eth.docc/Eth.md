# ``Eth``

`Eth.swift` is a very lightweight Ethereum library in Swift.

## Overview

`Eth.swift` supports ABI encoding and decoding and has a custom `EVM` which can run pure Ethereum code locally. Currently `Eth.swift` does not support any advanced features such as `JSON-RPC` or other common Ethereum features.

## Usage

### ABI

The ``ABI/Schema`` enum defines Ethereum ABI definitions and the ``ABI/Value`` enum defines an decoded value. You can use quickly encode ABI values using the ``ABI/Value/encoded`` computed property:

```swift
let data: Data = ABI.Value.tuple1(.array(.string, [.string("hello"), .string("world")])).encoded
```

and use ``ABI/Schema/decode(_:)`` to decode values.

```swift
let schema: ABI.Schema = .tuple([.array(.string)])

switch try schema.decode(data) {
case let .tuple1(.array(_, words)):
  print(words.map { $0.asString! }.joined(separator: " and "))
default:
  throw ABI.DecodeError.invalidResponse
}
```

As noted above, tuples are generally represented as `.tuple2(.uint8(1), .uint8(2))` to make unwrapping easy. You can also unwrap values using helper methods such as ``ABI/Value/asString``, ``ABI/Value/asBigUInt``, ....

### EVM

The ``EVM`` module allows you to run pure EVM code locally. E.g. if you had the following Solidity file:

```c
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract MyContract {
    function add55(uint256 x) pure external returns (uint256) {
        return 55 + x;
    }
}
```

Then, you could grab its deployed bytecode from `MyContract.sol/MyContract.json` and execute that function in the EVM via ``EVM/decodeCode(fromData:)`` and ``EVM/runQuery(bytecode:query:withValue:)``:

```swift
let code = try! EVM.decodeCode(fromData: Hex.hex("...")) // The deployed bytecode
let result = try! EVM.runQuery(bytecode: code, query: .tuple1(.uint256(22)))
print("result=" + result.asArray![0].asBigUInt!)
```

### Geno

For information on Swift code generation for Solidity contracts, see ``Geno``.

## Topics
### Essentials
- <doc:Hex>
- <doc:EthAddress>
- <doc:EVM>
- <doc:ABI>
- ``Geno``
