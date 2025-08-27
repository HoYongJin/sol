//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex5_2 {
    uint public x = 1;

    function addToX(uint y) public view returns (uint) {        // x를 읽을 수는 있지만 변경은 불가능
        return x + y;
    }

    function add(uint i, uint j) public pure returns (uint) {   // x를 읽을 수도 없음
        return i + j;
    }
}