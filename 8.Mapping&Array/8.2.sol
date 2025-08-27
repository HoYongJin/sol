//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Ex8_2 {
    struct Person {
        string name;
        uint age;
    }

    Person[] public people;

    function addPeron(string memory _name, uint _age) public {
        people.push(Person(_name, _age));
    }

    function getAdults() public view returns(Person[] memory){
        uint count = 0;
        for(uint i=0; i<people.length; i++) {
            if(people[i].age >= 19) {
                count++;
            }
        }

        Person[] memory temp = new Person[](count);
        for(uint i=0; i<people.length; i++) {
            if(people[i].age >= 19) {
                temp[--count] = people[i];
            }
        }
        return temp;
    }
}