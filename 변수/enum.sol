//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract enumTest {
    enum ActionChoices { GoLeft, GoRight, GoStraight, Stop }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;

    function setGoStraight() public {
        choice = ActionChoices.GoStraight;
    }

    function getChoice() public view returns(ActionChoices) {
        return choice;
    }

    function getDefaultChoice() public pure returns(uint) {
        return uint(defaultChoice);
    }
}