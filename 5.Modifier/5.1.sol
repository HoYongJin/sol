//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex5_1 {
    uint num = 0;

    function myBlock(uint a) public pure returns(uint, uint) {
        uint b = 10;
        return (a, b);
    }

    // function myBlock2() public pure returns(uint) {      // State Variable 참조 불가능
    //     num = 10;
    //     return num;
    // }

    function myBlock3() public view returns(uint) {
        uint b = 10 + num;                                  // State Variable 참조 가능
        //num = 100;                                        // State Variable을 참조(read)만 가능 변경(write)는 불가능
        return b;
    }
}