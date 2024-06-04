// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ComplianceTest} from "./ComplianceTest.sol";
import {Keccak} from "../src/Keccak.sol";

contract KeccakTest is ComplianceTest("KeccakTest", type(Keccak).runtimeCode) {
    function getContract() override internal returns (address) {
        return address(new Keccak());
    }

    function test_simpleKeccak() external {
        test(
            "simpleKeccak",
            abi.encodeWithSelector(Keccak.simpleKeccak.selector, 99)
        );
    }

    function test_simpleKeccakAbi() external {
        test(
            "simpleKeccakAbi",
            abi.encodeWithSelector(Keccak.simpleKeccakAbi.selector, "hello", 5, 6)
        );
    }
}
