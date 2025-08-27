//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_3 {
    uint[] public data;

    function addVal(uint _val) public returns(uint) {
        data.push(_val);
        return _val;
    }

    function remove(uint _val) public returns(uint) {
        for(uint i=0; i<data.length; i++) {
            if(data[i]==_val) {
                for(uint j=i; j<data.length-1; j++) {
                    data[j] = data[j+1];
                }
                return i;
            }
        }
        return 9999;
    }

}