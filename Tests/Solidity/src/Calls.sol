// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library Bibliotheca {
    function limit(uint256 x) pure internal returns (uint256) {
        if (x > 10) {
            return 10;
        } else {
            return x;
        }
    }

    function tally(uint256 x) pure internal returns (uint256) {
        return x * limit(x);
    }
}

contract Calls {
    function internalCall(uint256 x) pure internal returns (uint256) {
        return x * x + 1;
    }

    function callsInternal(uint256 x) pure external returns (uint256) {
        return internalCall(x) + internalCall(x + 1);
    }

    function callsLibrary(uint256 x) pure external returns (uint256) {
        return Bibliotheca.tally(x) + Bibliotheca.limit(x + 1);
    }
}
