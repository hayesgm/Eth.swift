// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Keccak {
    function simpleKeccak(uint8 x) pure external returns (bytes32) {
        bytes memory v = new bytes(10);
        v[0] = bytes1(x);
        v[9] = bytes1(x);
        return keccak256(v);
    }

    function simpleKeccakAbi(string calldata x, uint128 y, uint128 z) pure external returns (bytes32) {
        return keccak256(abi.encodePacked(x, y, z));
    }
}
