# 목차
- [Solidity](#solidity)
  - 정의
  - 실행 환경
  - 컴파일 산출물
- [EVM](#evm)
  - 정의
  - 필요성
  - 동작 방식
  - 컴파일 산출물

# $$Solidity$$

## 정의
이더리움이 제공하는 스마트 컨트랙트용 **정적 타입(Statically-typed)** 고급 언어.  
C++ / JavaScript / Python의 영향을 받음

## 실행 환경
- **EVM (Ethereum Virtual Machine)** 위에서 동작

## 컴파일 산출물
- **Bytecode** : EVM이 실행하는 저수준 코드  
- **ABI (Application Binary Interface)** : 앱에서 컨트랙트 함수를 어떻게 호출할지 정의한 JSON 인터페이스
<br><br><br><br><br>
# $$EVM$$

## 정의
1. **스택 기반 가상머신**  
   노드가 트랜잭션을 검증할 때 EVM이 동일한 바이트코드를 결정론적으로 실행
2. **데이터 영역 구분**  
   - storage (영구 저장소)  
   - memory (일시적 저장소)  
   - calldata (읽기 전용 입력)
3. **가스 시스템**  
   실행 비용을 가스로 측정하여 무한 루프 및 자원 남용을 방지

## 필요성
“누가 어디서 실행해도 결과가 동일”해야 합의가 가능하기 때문.  
만약 OS/CPU마다 다른 결과가 나오면 블록체인이 깨짐

## 동작 방식
- 트랜잭션이 들어오면 EVM은 **opcode (ADD, SLOAD, SSTORE, CALL …)** 단위로 실행  
- 스택과 메모리를 읽고 쓰며, 상태 변경은 `SSTORE`로 storage에 기록  
- 실행이 끝나면 `STOP` / `RETURN` / `REVERT` 등으로 종료  
- 소비된 가스를 정산

## 컴파일 산출물
- **Bytecode** : Solidity로 작성된 코드를 컴파일한 EVM 전용 실행 코드 (블록체인에 실제 배포됨)  
- **ABI (Application Binary Interface)** : 외부에서 이 컨트랙트의 함수를 호출할 때 어떤 버튼을 눌러야 하는지 알려주는 JSON 파일



---

