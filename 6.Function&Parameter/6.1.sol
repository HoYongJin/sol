//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex6_1 {
    uint public a = 4;

    function myBlock() public {
        a = 8;
    }

    function myBlock2(uint b) public {
        a = b;
    }

    function myBlock3(uint num1,uint num2,uint num3) public {
        a = num1;
        a = num2;
        a = num3;
    }

    function myBlock4() public returns(uint) {
        a = 999;
        return a;
    }

    function myBlock5() public pure returns(uint age, uint weight) {
        age = 20;
        weight = 30;
    }

    function getRef(string memory str) public pure returns(string memory) {   // 매개변수 혹은 리턴값으로 참조타입을 사용할 때 저장영역을 명시해야함
        return str;
    }
}