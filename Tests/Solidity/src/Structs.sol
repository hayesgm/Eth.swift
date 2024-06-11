
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

struct Cat {
    int256 ca;
    bytes cb;
    bytes32 cc;
}

struct Bat {
    uint96 a;
    uint160 b;
    Cat[] c;
    string d;
    uint256[] e;
}

contract Structs {
    function buildBat(uint256 x, uint256 y) pure external returns (Bat memory) {
        Cat[] memory cats = new Cat[](y);
        for (uint256 i = 0; i < y; i++) {
            cats[i] = Cat({
                ca: -int256(i),
                cb: new bytes(i),
                cc: hex"1122334455667788991122334455667788991122334455667788991122334455"
            });
        }
        uint256[] memory e = new uint256[](0);

        return Bat({
            a: uint96(x),
            b: uint96(x - 1),
            c: cats,
            d: "hello",
            e: e
        });
    }

    function acceptBat(Bat memory bat) pure external returns (int256) {
        int256 total = int160(bat.a * bat.b);
        for (uint256 i = 0; i < bat.c.length; i++) {
            total += int256(bat.c[i].cb.length) * bat.c[i].ca;
        }
        return total / -2;
    }
}
