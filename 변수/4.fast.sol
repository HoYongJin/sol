//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract fast {
    string public a = "Hello World!";
    uint public b = 1;

    function fetSt() public view {
        uint c = 2;

        uint d = block.timestamp;
        address e = msg.sender;
    }
}