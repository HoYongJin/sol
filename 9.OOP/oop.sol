// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
================================================================================
1. 추상화 (Abstraction)
================================================================================
'IAction'은 인터페이스(interface)로, 일종의 "규칙" 또는 "명세"입니다.
- 여기서는 'performAction'이라는 행동을 정의했지만, 구체적으로 어떻게 행동할지는 명시하지 않았습니다.
- 복잡한 내부 구현은 숨기고, "모든 캐릭터는 행동을 할 수 있어야 한다"는 필수 기능만 노출합니다.
- 이 인터페이스를 구현하는 모든 컨트랙트는 반드시 'performAction' 함수를 자신만의 방식으로 구현해야 합니다.
*/
interface IAction {
    function performAction() external pure returns (string memory);
}


/*
================================================================================
2. 캡슐화 (Encapsulation) & 3. 상속 (Inheritance)
================================================================================
'Character'는 기본 캐릭터 컨트랙트입니다.
*/
contract Character {
    /*
    ----------------------------------------------------------------------------
    캡슐화 (Encapsulation)
    ----------------------------------------------------------------------------
    - 캐릭터의 핵심 데이터(상태 변수)인 _name, _level, _health를 'private'으로 선언했습니다.
    - 이는 외부에서 직접 데이터를 수정하는 것을 막아 데이터의 무결성을 보호합니다.
    - 데이터에 접근하거나 읽기 위해서는 오직 'public'으로 공개된 함수(getter 함수)를 통해서만 가능합니다.
    - 이처럼 데이터와 데이터를 처리하는 함수를 하나의 단위로 묶고, 중요한 데이터는 숨기는 것을 캡슐화라고 합니다.
    */
    string private _name;
    uint private _level;
    uint private _health;

    // 생성자: 컨트랙트가 배포될 때 캐릭터의 초기 상태를 설정합니다.
    constructor(string memory name, uint level, uint health) {
        _name = name;
        _level = level;
        _health = health;
    }

    // 외부에서 private 변수인 _name을 읽을 수 있도록 제공하는 public 함수
    function getName() public view returns (string memory) {
        return _name;
    }

    // 외부에서 private 변수인 _level을 읽을 수 있도록 제공하는 public 함수
    function getLevel() public view returns (uint) {
        return _level;
    }

    // 외부에서 private 변수인 _health를 읽을 수 있도록 제공하는 public 함수
    function getHealth() public view returns (uint) {
        return _health;
    }
}


/*
================================================================================
3. 상속 (Inheritance) & 4. 다형성 (Polymorphism)
================================================================================
'Warrior'와 'Mage' 컨트랙트는 'Character'와 'IAction'을 상속받습니다.
- 'is Character' : Character 컨트랙트의 모든 public/internal 속성과 함수를 물려받습니다. (코드 재사용)
- 'is IAction' : IAction 인터페이스의 규칙을 따르겠다고 약속합니다. (기능 명세 구현)
*/

// 전사(Warrior) 컨트랙트
contract Warrior is Character, IAction {
    constructor(string memory name) Character(name, 5, 150) {}

    /*
    ----------------------------------------------------------------------------
    다형성 (Polymorphism)
    ----------------------------------------------------------------------------
    - 'performAction'이라는 동일한 이름의 함수를 'Warrior'에 맞게 재정의(Override)했습니다.
    - 외부에서는 똑같이 'performAction'을 호출하지만, 대상이 Warrior 객체이면 "검을 휘두릅니다!"라는 고유한 행동이 실행됩니다.
    - 이처럼 같은 이름의 함수가 객체의 타입에 따라 다르게 동작하는 것을 다형성이라고 합니다.
    */
    function performAction() external pure override  returns (string memory) {
        return "WarriorWarriorWarrior";
    }
}

// 마법사(Mage) 컨트랙트
contract Mage is Character, IAction {
    constructor(string memory name) Character(name, 5, 80) {}

    function performAction() external pure override returns(string memory) {
        return "MageMageMage";
    }
}

// 실행 예제: 다형성을 확인하기 위한 컨트랙트
contract GameManager {
    // 이 함수는 'IAction' 인터페이스를 따르는 어떤 컨트랙트의 주소든 받을 수 있습니다.
    // 전달된 주소가 Warrior이든 Mage이든 상관없이, 'performAction' 함수를 호출할 수 있습니다.
    function triggerAction(IAction ia) public pure returns(string memory) {
        return ia.performAction();
    }
}