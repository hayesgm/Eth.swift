// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicOperations {
    function returnValue() pure external returns (uint256) {
        return 55;
    }

    function addition(uint256 x) pure external returns (uint256) {
        return 55 + x;
    }

    function subtraction(uint256 x) pure external returns (uint256) {
        return 55 - x;
    }

    function multiplication(uint256 x) pure external returns (uint256) {
        return 55 * x;
    }

    function division(uint256 x) pure external returns (uint256) {
        return 55 / x;
    }

    function signedDivision(int256 x) pure external returns (int256) {
        return 55 / x;
    }
}
