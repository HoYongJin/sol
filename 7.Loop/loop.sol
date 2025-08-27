//SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract For {
    event CountryIndexName(uint indexed _index, string _name);
    string[] private countryList = ["South Korea", "North Korea", "USA", "China", "Japan"];

    // string은 솔리디티 내에서 비교불가
    // string --> bytes 변경해서 keccak256(해시) 후 결과를 비교
    function linearSearch(string memory str) public view returns(uint, string memory) {
        for(uint i=0; i<countryList.length; i++) {
            if(keccak256(bytes(countryList[i])) == keccak256((bytes(str)))) {
                return (i, countryList[i]);
            }
        }

        return (0, "NONE");
    }
}