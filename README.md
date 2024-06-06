# Eth.swift

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

## Generating Swift from ABI

To generate Swift files from ABI json files (e.g. the `out/` directory of forge build), run:

```
swift run EthCodeGen Tests/Solidity/out/Cool.sol/Cool.json --outDir Tests/Gen
```

## Compliance Tests

Compliance tests are Solidity tests which log their results. We then compare the output of the Eth.swift EVM to those results to ensure compliance over a variety of real Solidity contracts.

To build compliance tests, make sure to install `forge` and install submodules `git submodule update --init --recursive` and then run `./Tests/Solidity/build-compliance-tests.sh`. Note: you do not need to run this unless you are editing the Compliance tests.

## Coding Conventions

Please use `swiftformat` on all files before checking in. To install `swiftformat`, run `brew install swiftformat`.
