//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract MyStorage {
    function getResult() public view returns(uint) {
        return block.number;    // global variable 반환
    }
}