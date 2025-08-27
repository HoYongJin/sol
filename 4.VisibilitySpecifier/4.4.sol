//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex4_4 {
    function funcExt() external pure returns(uint) {
        return 2;
    }

    function outPutExt() public view returns(uint) {
        return this.funcExt();              // external로 선언된 funcExt()를 직접 컨트랙트 내부에서 호출 할 수는 없지만 this를 통해서 호출은 가능
    }
}