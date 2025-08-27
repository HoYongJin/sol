//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex4_1 {
    uint a = 5;                     // default로 internal 설정
    uint public b = 10;             // 자동으로 getter 함수 생성 
    uint public constant c = 20;    // 자동으로 getter 함수 생성 
    uint private d = 30;            // 내부에서만 접근 가능 
}