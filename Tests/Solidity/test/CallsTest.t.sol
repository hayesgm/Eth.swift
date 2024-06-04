// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ComplianceTest} from "./ComplianceTest.sol";
import {Calls} from "../src/Calls.sol";

contract CallsTest is ComplianceTest("CallsTest", type(Calls).runtimeCode) {
    function getContract() override internal returns (address) {
        return address(new Calls());
    }

    function test_callsInternal() external {
        test(
            "callsInternal",
            abi.encodeWithSelector(Calls.callsInternal.selector, 22)
        );
    }

    function test_callsLibrary() external {
        test(
            "callsLibrary",
            abi.encodeWithSelector(Calls.callsLibrary.selector, 22)
        );
    }
}
