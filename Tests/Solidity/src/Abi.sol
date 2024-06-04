// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Abi {
    function simpleAbiEncoding(uint256 x, string calldata y) pure external returns (bytes memory) {
        return abi.encode(x, y);
    }

    function simpleAbiEncodingPacked(uint256 x, string calldata y) pure external returns (bytes memory) {
        return abi.encodePacked(x, y);
    }

    function abiEncodeSelector(uint256 x) pure external returns (bytes memory) {
        return abi.encodeWithSelector(Abi.abiEncodeSelector.selector, x * x);
    }
}
