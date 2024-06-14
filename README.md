# Eth.swift

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fhayesgm%2FEth.swift%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/hayesgm/Eth.swift) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fhayesgm%2FEth.swift%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/hayesgm/Eth.swift)

A lightweight Ethereum library in Swift.

## Running Tests

Run the tests using `swift test`, preferably with `xcbeautify`:

```sh
swift test | xcbeautify
```

(install xcbeautify via `brew install xcbeautify`)

For testing with EVM debug information:

```sh
swift test -Xswiftc -DDEBUG_EVM
```

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

## Generating Swift from ABI

To generate Swift files from ABI json files (e.g. the `out/` directory of `forge build`), run:

```sh
swift run Geno ./out/Cool.sol/Cool.json --outDir Sources/
```

It's also suggested you run `swiftformat` on the generated file. See ``Geno`` for more information on code generation.

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

## Compliance Tests

Compliance tests are Solidity tests which log their results. We then compare the output of the Eth.swift EVM to those results to ensure compliance over a variety of real Solidity contracts.

To build compliance tests, make sure to install `forge` and install submodules `git submodule update --init --recursive` and then run `./Tests/Solidity/build-compliance-tests.sh`. Note: you do not need to run this unless you are editing the Compliance tests.

## Coding Conventions

Please use `swiftformat` on all files before checking in. To install `swiftformat`, run `brew install swiftformat`.
