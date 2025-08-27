//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_1 {
    mapping(address => mapping(string => bool)) private roles;

    event RoleGranted(address indexed user, string role);
    event RoleRevoked(address indexed user, string role);

    address public admin;

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this");
        _;
    }

    function grantRole(address _user, string memory _role) public onlyAdmin {
        roles[_user][_role] = true;
        emit RoleGranted(_user, _role);
    }

    function revokeRole(address _user, string memory _role) public onlyAdmin {
        delete roles[_user][_role];
        emit RoleRevoked(_user, _role);
    }

    function hasRole(address _user, string memory _role) public view returns(bool){
        return roles[_user][_role];
    }

    function writeArticle() public view returns(string memory) {
        require(hasRole(msg.sender, "Writer"), "You are not a writer");
        return "Article submitted!";

    }

}