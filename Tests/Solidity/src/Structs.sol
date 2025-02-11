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
    bytes32[][] g;
}

struct Dat {
    bytes32[][] a;
    bytes32[][] b;
}

library Animal {
    struct Rat {
        address a;
    }

    struct Moose {
        uint b;
    }

    struct Goose {
        uint b;
        string c;
    }
}

contract Structs {
    error JustAName();
    error JustOneArg(bool);

    function buildNestedArray(uint256 x) external pure returns (uint256[][] memory) {
       uint256[][] memory arr = new uint256[][](1);
       uint256[] memory innerArr = new uint256[](1);
       innerArr[0] = x;
       arr[0] = innerArr;
       return arr;
    }

    function acceptNestedArray(uint256[][] memory arr) external pure returns (uint256) {
        return arr[0][0];
    }

    function buildDat(bytes32 x) external pure returns (Dat memory) {
       bytes32[][] memory arr = new bytes32[][](1);
       bytes32[] memory innerArr = new bytes32[](1);
       innerArr[0] = x;
       arr[0] = innerArr;
       return Dat({a: arr, b: arr});
    }

    function acceptDat(Dat memory x) external pure returns (bytes32) {
        return x.a[0][0];
    }

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

       bytes32[][] memory g = new bytes32[][](1);
       bytes32[] memory innerG = new bytes32[](1);
       innerG[0] = hex"deadbeef";
       g[0] = innerG;

        return
            Bat({
                a: uint96(x),
                b: uint96(x - 1),
                c: cats,
                d: "hello",
                e: es,
                f: cats[0],
                g: g
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
    ) external pure returns (bool)  {
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

    function emptyGoose() external pure returns (Animal.Goose memory) {
        Animal.Goose[] memory rs = new Animal.Goose[](1);
        rs[0].c = "USDC";
        return rs[0];
    }


    function anotherEmptyGoose() external pure returns (bytes memory) {
       // when "manually" abi encoding to bytes the return value is slightly different, so testing both
        Animal.Goose[] memory rs = new Animal.Goose[](1);
        return abi.encode(rs[0]);
    }
}
