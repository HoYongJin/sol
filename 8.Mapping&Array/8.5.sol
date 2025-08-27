//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_5 {
    function sortArray(uint[] memory arr) public pure returns(uint[] memory) {
        for(uint i=0; i<arr.length; i++) 
            for(uint j=i; j<arr.length; j++) 
                if(arr[i] > arr[j]) 
                    (arr[i], arr[j]) = (arr[j], arr[i]);
                
        return arr;
    }


}