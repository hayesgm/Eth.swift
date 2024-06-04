// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ComplianceTest} from "./ComplianceTest.sol";
import {Abi} from "../src/Abi.sol";

contract AbiTest is ComplianceTest("AbiTest", type(Abi).runtimeCode) {
    function getContract() override internal returns (address) {
        return address(new Abi());
    }

    function test_simpleAbiEncoding() external {
        test(
            "simpleAbiEncoding",
            abi.encodeWithSelector(Abi.simpleAbiEncoding.selector, 22, "hello")
        );
    }

    function test_simpleAbiEncodingPacked() external {
        test(
            "simpleAbiEncodingPacked",
            abi.encodeWithSelector(Abi.simpleAbiEncodingPacked.selector, 22, "hello")
        );
    }

    function test_abiEncodeSelector() external {
        test(
            "abiEncodeSelector",
            abi.encodeWithSelector(Abi.abiEncodeSelector.selector, 22)
        );
    }
}
