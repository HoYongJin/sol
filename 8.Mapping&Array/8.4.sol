//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_4 {
    uint[] public values;
    mapping(uint => bool) public exists;

    function addVal(uint _val) public {
        require(!exists[_val], "Already Exist");
        values.push(_val);
        exists[_val] = true;
    }

    function removeVal(uint _val) public {
        require(exists[_val], "Does Not Exist");

        for(uint i=0; i<values.length; i++) {
            if(values[i] == _val) {
                values[i] = values[values.length-1];
                values.pop();
                exists[_val] = false;

                break;
            }
        }
    }

    function getValues() public view returns(uint[] memory) {
        return values;
    }
}