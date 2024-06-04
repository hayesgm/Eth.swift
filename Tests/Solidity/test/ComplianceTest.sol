// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

abstract contract ComplianceTest is Test {
    string name;
    bytes bytecode;

    constructor(string memory name_, bytes memory bytecode_) {
        name = name_;
        bytecode = bytecode_;
    }

    function getContract() virtual internal returns (address);

    function concatenate(string memory s1, string memory s2) internal pure returns (string memory) {
        bytes memory b1 = bytes(s1);
        bytes memory b2 = bytes(s2);
        string memory concatenatedString = new string(b1.length + b2.length);
        bytes memory bConcatenatedString = bytes(concatenatedString);

        uint k = 0;
        for (uint i = 0; i < b1.length; i++) bConcatenatedString[k++] = b1[i];
        for (uint i = 0; i < b2.length; i++) bConcatenatedString[k++] = b2[i];

        return string(bConcatenatedString);
    }

    function complianceTest(string memory testName, bytes memory query, bytes memory resp) internal {
        // TODO: I don't get this JSON stuff at all
        string memory testJson = "{}";
        vm.serializeString(testJson, "name", concatenate(concatenate(name, ":"), testName));
        vm.serializeBytes(testJson, "bytecode", bytecode);
        vm.serializeBytes(testJson, "query", query);
        vm.serializeBytes(testJson, "expResp", resp);

        string memory finalJson = vm.serializeBool(testJson, "expSuccess", true);

        vm.writeJson(finalJson,
            concatenate(
                concatenate(
                    concatenate(
                        concatenate("../ComplianceJson/", name),
                        "-"
                    ),
                    testName
                ),
                ".json"
            )
        );
    }

    function test(string memory testName, bytes memory query) internal {
        (bool success, bytes memory resp) = getContract().call(query);
        assertTrue(success, concatenate(concatenate(concatenate("Query failed in test ", name), ":"), testName));

        complianceTest(
            testName,
            query,
            resp
        );
    }
}
