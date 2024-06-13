// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Cool {
    error TooCool();
    error LukeWarm(bool);

    function sum(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function vibeCheck(uint status) external pure returns (bool) {
        if (status >= 100) {
            return true;
        } else if (status < 50) {
            revert TooCool();
        } else {
            revert LukeWarm(true);
        }
    }
}
