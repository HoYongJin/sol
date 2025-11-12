// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
================================================================================
1. 오버라이딩 (Overriding) 예제
================================================================================
- 상속 관계에 있는 두 컨트랙트(Drawing, Circle) 사이에서 발생합니다.
- 부모의 함수를 자식이 자신의 목적에 맞게 재정의하는 것입니다.
*/

// 부모 컨트랙트: Drawing
contract Drawing {
    // 이 함수는 자식 컨트랙트에서 재정의(override)될 수 있음을 'virtual' 키워드로 명시합니다.
    function draw() public pure virtual returns (string memory) {
        return "Drawing";
    }
}

// 자식 컨트랙트: Circle
// 'is Drawing'을 통해 Drawing 컨트랙트를 상속받습니다.
contract Circle is Drawing {
    // 부모의 draw() 함수를 재정의한다는 것을 'override' 키워드로 명시합니다.
    // 함수 시그니처(이름, 파라미터, 반환 타입)는 부모와 완전히 동일해야 합니다.
    function draw() public pure override returns (string memory) {
        return "Drawing Circle";
    }
}

/*
================================================================================
2. 오버로딩 (Overloading) 예제
================================================================================
- 하나의 컨트랙트(Calculator) 내에서 발생합니다.
- 함수 이름은 같지만, 파라미터의 개수나 타입이 다른 여러 함수를 정의하는 것입니다.
*/

contract Calculator {
    // 함수 이름은 'add'로 모두 동일합니다.

    // 오버로딩 1: uint 타입의 파라미터 2개를 받습니다.
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }

    // 오버로딩 2: uint 타입의 파라미터 3개를 받습니다.
    function add(uint a, uint b, uint c) public pure returns (uint) {
        return a + b + c;
    }

    // 오버로딩 3: string 타입의 파라미터 2개를 받습니다. (문자열을 합칩니다)
    // 이처럼 파라미터의 '타입'이 달라도 오버로딩이 가능합니다.
    function add(string memory a, string memory b) public pure returns (string memory) {
        return string.concat(a, b);
    }
}