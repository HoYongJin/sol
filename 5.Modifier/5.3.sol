//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex5_3 {
    uint public a = 3;

    function myBlock() public returns(uint) {           // non-pure, non-view : State Variable을 읽고, 쓰기 가능
        a = 4;
        return 4;
    }
}