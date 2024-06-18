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
    Cat f;
}

library Animal {
    struct Rat {
        address a;
    }

    struct Moose {
        uint b;
    }
}

contract Structs {
    function buildBat(uint256 x, uint256 y) external pure returns (Bat memory) {
        Cat[] memory cats = new Cat[](y);
        for (uint256 i = 0; i < y; i++) {
            cats[i] = Cat({
                ca: -int256(i),
                cb: new bytes(i),
                cc: hex"1122334455667788991122334455667788991122334455667788991122334455"
            });
        }

        uint256[] memory es = new uint256[](y);
        for (uint256 i = 0; i < y; i++) {
            es[i] = i ** i;
        }

        return
            Bat({
                a: uint96(x),
                b: uint96(x - 1),
                c: cats,
                d: "hello",
                e: es,
                f: cats[0]
            });
    }

    function acceptBat(Bat memory bat) external pure returns (int256) {
        int256 total = int160(bat.a * bat.b);
        for (uint256 i = 0; i < bat.c.length; i++) {
            total += int256(bat.c[i].cb.length) * bat.c[i].ca;
        }
        return total / -2;
    }

    function lookAtMoose(
        Animal.Moose[] memory moose,
        uint m
    ) external pure returns (bool) {
        for (uint256 i = 0; i < moose.length; i++) {
            if (moose[i].b == m) {
                return true;
            }
        }
        return false;
    }

    function lookAtRat(
        Animal.Rat memory rat,
        address[] memory holes
    ) external pure returns (address) {
        for (uint256 i = 0; i < holes.length; i++) {
            if (holes[i] == rat.a) {
                return rat.a;
            }
        }

        return address(0);
    }
}
