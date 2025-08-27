//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex4_3 {
    function funcExt() external pure returns(uint) {
        return 2;
    }

    function funcPriv() private pure returns(uint) {
        return 3;
    }

    function outPutExt1() public pure returns(uint) {
        //return funcExt();                 // funcExt()는 외부에서만 호출 가능 
    }

    function outPutPriv() public pure returns(uint) {
        return funcPriv();                  // 외부에서는 funcPriv()를 호출 불가능하지만 같은 컨트랙트 내에서는 호출 가능함
    }
}