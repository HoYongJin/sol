//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex4_2 {
    uint public pub = 1;            // public은 getter 함수를 생성해줌
    uint private pri = 2;
    uint internal inter = 3;
    //uint external ext = 4;        // external은 function에만 부여 가능

    function funcPub() public view returns(uint, uint, uint) {
        return (pub, pri, inter);
    }

    function funcPriv() private view returns(uint, uint, uint) {        // 외부에서 확인 불가
        return (pub, pri, inter);
    }

    function funcInter() internal view returns(uint, uint, uint) {      // 외부에서 확인 불가
        return (pub, pri, inter);
    }

    function funcExt() external view returns(uint, uint, uint) {
        return (pub, pri, inter);
    }
}