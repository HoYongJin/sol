//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_6 {
    function reverseArr(uint[] memory arr) public pure returns(uint[] memory) {
        for(uint i=0; i<(arr.length/2); i++) 
            (arr[i], arr[arr.length - 1 -i]) = (arr[arr.length - 1 -i], arr[i]);
        return arr;
    }
}