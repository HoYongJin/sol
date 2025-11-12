// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Vault
 * @dev require, revert, assert의 차이점을 보여주는 간단한 금고 컨트랙트입니다.
 */
contract Vault {
    mapping(address => uint) public balances; // 각 사용자별 잔고
    uint public totalSupply;                  // 금고에 있는 총 금액
    address public owner;                      // 금고의 소유자

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice 금고에 이더를 입금합니다.
     */
    function deposit() public payable {
        // --- require 사용 예시 ---
        // "경호원" 역할: 함수 실행 전 기본적인 조건을 검사합니다.
        // 조건 1: 입금액이 0보다 커야 합니다. (사용자 입력값 검증)
        // 조건 2: 금고 소유자는 입금할 수 없습니다. (내부 정책/규칙 검증)
        require(msg.value > 0, "Deposit amount must be greater than zero.");
        require(msg.sender != owner, "Owner cannot deposit.");

        balances[msg.sender] += msg.value;
        totalSupply += msg.value;
    }

    /**
     * @notice 금고에서 `amount` 만큼의 이더를 출금합니다.
     * @param amount 출금할 금액
     */
    function withdraw(uint amount) public {
        // --- revert 사용 예시 ---
        // 복잡한 로직 속에서 특정 조건이 맞지 않을 때 수동으로 실행을 중단시킵니다.
        if (balances[msg.sender] < amount) {
            // require(balances[msg.sender] >= amount, "..."); 와 기능적으로 동일하지만,
            // 이처럼 if-else 구문 안에서 명시적으로 에러를 발생시킬 때 유용합니다.
            revert("Insufficient balance for withdrawal.");
        }

        balances[msg.sender] -= amount;
        totalSupply -= amount;

        // --- assert 사용 예시 ---
        // "비상 정지 버튼" 역할: 코드의 내부 상태가 절대 깨져서는 안 되는지 확인합니다.
        // 출금 후, 금고의 총액이 특정 사용자의 잔고보다 적어지는 것은 논리적으로 불가능합니다.
        // 만약 이 조건이 깨진다면, 이는 외부의 잘못이 아닌 코드 내부에 심각한 버그(예: 언더플로우)가 있다는 신호입니다.
        assert(totalSupply >= balances[msg.sender]);

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether.");
    }
}


// ==========================================================================================
// try/catch를 보여주기 위한 외부 컨트랙트 예시
// ==========================================================================================
interface IExternalChecker {
    function checkStatus(address user) external view returns (bool);
}

contract StatusManager {
    IExternalChecker externalChecker;
    address public lastCheckedUser;
    bool public lastStatus;

    constructor(address checkerAddress) {
        externalChecker = IExternalChecker(checkerAddress);
    }

    /**
     * @notice 외부 컨트랙트를 호출하여 사용자의 상태를 확인합니다.
     * 외부 호출이 실패하더라도 전체 트랜잭션은 멈추지 않습니다.
     */
    function checkUserStatus(address user) public {
        // --- try/catch 사용 예시 ---
        // "외부 통신 예외 처리" 역할: 외부 컨트랙트 호출의 실패에 대비합니다.
        try externalChecker.checkStatus(user) returns (bool status) {
            // 외부 호출이 성공했을 경우:
            lastStatus = status;
            lastCheckedUser = user;
        } catch {
            // 외부 호출이 실패했을 경우 (예: 해당 컨트랙트가 존재하지 않거나, 함수 실행 중 revert 발생):
            // 이 블록이 실행되고, 트랜잭션은 중단되지 않고 계속 진행됩니다.
            lastStatus = false; // 실패 시 기본값으로 설정
            lastCheckedUser = user; // 실패했더라도 어떤 유저를 확인했는지는 기록
        }
    }
}
