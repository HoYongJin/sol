//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract MyStorage {
    function getResult() public pure returns(uint) {
        uint local_var1 = 1;
        uint local_var2 = 2;
        uint result = local_var1 + local_var2;

        return result;
    }
}