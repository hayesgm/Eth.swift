// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ComplianceTest} from "./ComplianceTest.sol";
import {BasicOperations} from "../src/BasicOperations.sol";

contract BasicOperationsTest is ComplianceTest("BasicOperationsTest", type(BasicOperations).runtimeCode) {

    function getContract() override internal returns (address) {
        return address(new BasicOperations());
    }

    function test_returnValue() external {
        test(
            "returnValue",
            abi.encodeWithSelector(BasicOperations.returnValue.selector)
        );
    }

    function test_addition() external {
        test(
            "addition",
            abi.encodeWithSelector(BasicOperations.addition.selector, 22)
        );
    }

    function test_subtraction() external {
        test(
            "subtraction",
            abi.encodeWithSelector(BasicOperations.subtraction.selector, 22)
        );
    }

    function test_multiplication() external {
        test(
            "multiplication",
            abi.encodeWithSelector(BasicOperations.multiplication.selector, 22)
        );
    }

    function test_division() external {
        test(
            "division",
            abi.encodeWithSelector(BasicOperations.division.selector, 22)
        );
    }

    function test_signedDivision() external {
        test(
            "signedDivision",
            abi.encodeWithSelector(BasicOperations.signedDivision.selector, -22)
        );
    }
}
