## Solidity Compliance Tests

Solidity Compliance Tests are Solidity tests that are used to generate controlled output which can be compared to Eth.swift's EVM. These are called "compliance tests" as they ensure that Eth.swift's EVM is in compliance with forge's own EVM.

## Adding a test

Add a contract under `src/`. Ensure that all functions are `pure`.

Add a test under `test/` that will be used to turn your tests into JSON tests in core `Tests/ComplianceJson/`:

```js
contract MyComplianceTest is ComplianceTest("MyComplianceTest", type(MyCompliance).runtimeCode) {

    function getContract() override internal returns (address) {
        return address(new MyCompliance());
    }

    function test_someFunction() external {
        test(
            "someFunction",
            abi.encodeWithSelector(MyCompliance.someFunction.selector, 22)
        );
    }
```

Then simply run:

```
./build-compliance-tests.sh
```

or simply `forge test`.
