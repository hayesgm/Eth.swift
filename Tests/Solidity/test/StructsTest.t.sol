// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ComplianceTest} from "./ComplianceTest.sol";
import {Structs} from "../src/Structs.sol";

contract StructsTest is ComplianceTest("StructsTest", type(Structs).runtimeCode) {
    function getContract() override internal returns (address) {
        return address(new Structs());
    }

    function test_buildBat() external {
        test(
            "buildBat",
            abi.encodeWithSelector(Structs.buildBat.selector, 22, 3)
        );
    }

    function test_acceptBat() external {

        test(
            "acceptBat",
            abi.encodeWithSelector(Structs.acceptBat.selector, new Structs().buildBat(22, 3))
        );
    }
}
