// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title InvariantToken
 * @dev `assert`를 사용하여 컨트랙트의 핵심 불변 조건(invariant)을
 * 검증하는 방법을 보여주는 예제 토큰 컨트랙트입니다.
 * 불변 조건이란, 컨트랙트 상태가 어떻게 변하든 항상 참이어야 하는 규칙을 의미합니다.
 */
contract InvariantToken {
    mapping(address => uint) public balances;
    uint public totalSupply;

    // 이 컨트랙트의 핵심 불변 조건:
    // "어떤 경우에도, 토큰의 총 공급량은 특정 한 개인의 잔고보다 작을 수 없다."
    // 이 규칙이 깨진다면, 코드 어딘가에 심각한 버그가 있다는 뜻입니다.
    constructor() {
        // 컨트랙트 배포자에게 1000개의 토큰을 발행합니다.
        totalSupply = 1000;
        balances[msg.sender] = 1000;
    }

    /**
     * @notice 다른 주소로 토큰을 전송합니다.
     * @param to 토큰을 받을 주소.
     * @param amount 전송할 토큰의 양.
     */
     function transfer(address to, uint amount) public {
        // require: 사용자 입력값과 조건을 검사합니다. (정상적인 오류 처리)
        require(balances[msg.sender] >= amount, "Insufficient balance.");

        // 상태 변경
        balances[msg.sender] -= amount;
        balances[to] += amount;

        
    }
}