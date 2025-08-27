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
- **Bytecode** : Solidity로 작성된 코드를 컴파일한 EVM 전용 실행 코드 (블록체인에 실제 배포됨)  
- **ABI (Application Binary Interface)** : 외부에서 이 컨트랙트의 함수를 호출할 때 어떤 버튼을 눌러야 하는지 알려주는 JSON 파일

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

<br><br><br><br><br>

# $$variable$$

## 변수의 종류
1. **State Variables(상태변수)**  
    - 함수 바깥(컨트랙트 안)에 선언되는 변수로,블록체인의 영구 저장소(storage)에 기록되는 변수
    - 함수 외부, 컨트랙트 본문 안에 선언
    - 컨트랙트가 배포될 때 초기화
    - 트랜잭션이 실행되면 값이 업데이트되고 영구 기록
    - storage 영역에 저장되므로 가스비가 발생
2. **Local Variables(지역변수)**
    - 함수 안에서 선언되는 변수로, 함수가 실행되는 동안만 존재하고 블록체인에 저장되지 않는 변수
    - memory에 저장되며, 일시적인 임시 변수
    - 함수 실행이 끝나면 자동으로 사라짐
    - 값을 외부에서 조회하거나 추적할 수 없음
3. **Global Variables(전역변수)**
    - Solidity에서 자동으로 제공되는 내장 변수
    - 블록체인 또는 트랜잭션의 정보를 함수 내에서 어디서든 사용 가능
    - msg, block, tx 같은 객체나 키워드를 통해 접근

## 저장소의 종류
1. **storage**
    - 컨트랙트의 상태 변수들이 저장되는 공간으로, 블록체인에 영구히 저장(key–value 구조)
    - State Variables(상태변수)에 해당
    - 가스 비용이 가장 큼
2. **memory**
    - 임시 참조 타입 저장 공간
    - 함수 실행 중에만 존재
    - 함수 실행 중 임시로 사용하는 저장공간(읽고 쓰기 가능)
    - EVM이 동작할 때만 존재하고, 실행이 끝나면 사라짐
3. **calldata**
    - 외부 함수에 전달된 입력 값이 저장되는 읽기 전용 공간
    - external 함수에서만 사용 가능
4. **stack**
    - EVM 연산의 중심, EVM이 연산할 때 사용하는 임시 저장 공간(LIFO)
    - 1024개의 32바이트 슬롯
    - 함수 실행 중에만 존재
    - 변수 이름 없이 내부적으로 사용

<br><br><br><br><br>

# $$Data Type(자료형)$$

## Data Type  
- 변수에 어떤 종류의 값이 들어갈 수 있는지 정의하는 것
- Solidity는 정적 타입 언어라서, 모든 변수 선언 시 자료형을 반드시 명시해야함

## Value Type
- 변수에 실제 값 자체가 저장되는 타입
- 할당하거나 함수에 넘기면 값이 복사
- 원본과 복사본은 서로 영향을 주지 않음
- EVM의 stack에 저장

## Value Type Example
1. uint / int
    - 정수를 저장
    - 내부적으로 EVM은 256비트 연산 유닛을 사용하기 때문에, uint256이 기본
    - uint8, uint16 등은 Solidity 레벨에서만 구분되고, EVM에선 256비트로 패딩
2. bool 
    - true, flase 를 저장
    - 0 --> false, 그 외 모든 값 --> true
3. address
    - 이더리움 블록체인의 계정(EOA / CA)을 식별하기 위한 20바이트 값
    - 이더 송금, 컨트랙트 호출, msg.sender 비교 등 여러가지 역할을 수행함
4. bytes(1~32)
    - 고정 길이(1bytes ~ 32bytes) 바이트 배열
5. enum
    - 열거형(enumeration) 자료형으로, 여러 개의 이름 있는 상수값을 0부터 자동으로 번호를 부여한 정수 상수 집합


## Reference Type
- 변수에 값의 주소(참조)만 저장되는 타입
- 변수는 그 위치를 가리키기만 함
- 값을 대입하거나 인자로 넘길 때 주소(참조)만 복사
- 참조 타입은 선언 시 어디에 저장할지를 반드시 명시해야 함

## Reference Type Example
1. bytes
    - 가변 길이 바이트 배열
    - 길이가 유동적이기 때문에 스택에 직접 넣을 수 없음, 변수에는 메모리 주소(참조)만 저장되고 실제 데이터는 memory / storage / calldata에 저장됨
2. string
    - UTF-8로 인코딩된 문자들의 가변 길이 배열
    - 내부적으로는 사실상 bytes의 별칭(alias)이며, 기술적으로는 bytes와 동일한 구조를 가짐
3. array
    - 정적 또는 가변 길이의 값들의 연속된 모음
    - 데이터가 저장되는 위치(storage/memory/calldata)를 명시해야 함
4. struct
    - 사용자 정의 자료구조
    - 여러 개의 다른 타입 값을 하나의 구조체로 묶은 복합 데이터 타입
    - 전체 구조체를 다룰 때는 참조로 처리되며, 저장 위치를 명시해야 함
5. mapping
    - 키 --> 값 형태로 데이터를 저장하는 해시 테이블
    - 항상 storage에만 존재 가능 (함수에서 memory나 calldata로 전달 불가능)
    - 키는 값 타입만 가능, 값은 어떤 타입이든 가능

<br><br><br><br><br>

# $$Visibility Specifiers(가시성 지정자)$$

## public
- 외부/내부 어디서든 호출 가능(누구나 접근 가능)
- Solidity가 자동으로 getter 함수도 생성해줌 (변수일 경우)

## external
- 외부 컨트랙트/계정에서만 호출 가능(외부 전용 함수)
- 내부에서는 직접 호출 불가능 (call by this로는 가능)

## internal
- 현재 컨트랙트와 이를 상속한 자식 컨트랙트에서만 접근 가능
- 외부 컨트랙트나 계정에서는 접근 불가능
- state variable은 default로 internal 선언

## private
- 오직 선언한 컨트랙트 안에서만 접근 가능
- 상속받은 자식 컨트랙트에서도 접근 불가

<br><br><br><br><br>

# $$Modifier(모디파이어)$$

## Pure
- 순수 함수(pure function)를 의미하며, 상태(state)에 전혀 의존하지 않고 오직 입력값만으로 동작하는 함수(블록체인 상태, 상태 변수, 전역 변수 등과 완전히 독립적)
- 상태 변수 읽기 / 쓰기 불가능
- 블록 관련 전역 변수 접근 불가능
- this, address(this) 호출 불각능
- 입력값과 내부 계산만 허용 

## View
- 블록체인의 상태(state)를 읽기만 하고 변경하지 않는 함수
- 상태 변수나 블록 정보에 접근(read) 은 가능하지만, 수정(write) 은 불가능
- view 함수에서 pure 함수 호출 가능

## non-view, non-pure --> General
- 상태 변수를 읽거나 쓸 수 있고, 블록체인의 상태를 변경할 수 있는 함수

<br><br><br><br><br>

# $$Function\&Parameter$$

## Function
- 특정한 작업을 수행하기 위한 코드 블록
- 스마트컨트랙트의 행동(behavior)을 정의하며, 입력값(parameter)을 받아 처리하고, 출력값(return value)을 반환하거나 상태를 변경
- 재사용성: 동일한 작업을 반복할 때 함수로 만들어 쉽게 호출
- 분리와 구조화: 로직을 명확하게 나누고 가독성을 높임

## Parameter
- 함수에 전달되는 입력값(인자)의 이름과 자료형을 지정하는 변수
- 함수 내부에서 변수처럼 사용

<br><br><br><br><br>

# $$Mapping$$

## Mapping
- "키(key) --> 값(value)"을 효율적으로 저장하고 빠르게 조회할 수 있는 해시 테이블 기반 자료구조(JavaScript의 object)
- mapping(KeyType => ValueType) mappingName; 이런식으로 선언 함
- non-iterable(for문으로 key 순회 불가능)
- 키 존재 여부 확인 불가능(존재하지 않는 key를 조회하면 default value를 반환)
- 함수 파라미터로 전달 불가
- 모든 mapping은 반드시 storage에 존재
- delete를 이용해서 값 삭제

## nested mapping
- mapping의 값(ValueType)으로 또 다른 mapping을 사용하는 자료구조
- mapping(address => mapping(uint => bool)) public voted;  
voted[msg.sender][proposalId]  
voted[주소][제안ID] = true --> 투표 완료

<br><br><br><br><br>

# $$Array$$

- 같은 타입의 데이터를 연속적으로 저장하는 자료구조
- 정적 배열: 길이가 고정됨(컴파일 타임에 크기 결정)
- 동적 배열: 길이가 유동적(추가/삭제 가능)
- push: 배열 끝에 값 추가(동적 배열만 가능)
- pop: 배열 맨 끝 요소 제거(동적 배열만 가능)
- delete arr[index]: 특정 인덱스 초기화 (길이는 그대로)
- delete arr: 전체 배열 초기화 (길이도 0)
- length: 배열 길이 조회
- storage --> storage: 참조 복사
- storage --> memory: 값 복사
- memory --> memory: 값 복사

<br><br><br><br><br>

# $$Object-Oriented Programming(OOP)$$

## Event
- 컨트랙트에서 외부로 발생을 알리는 메시지
- 이벤트 핸들러(리스너)에게 상태 변화나 특정 동작의 발생을 전달하는 메커니즘
- 발생자(emitter)와 구독자(listener) 사이의 느슨한 연결(loose coupling)을 위한 구조
- 블록체인에 로그 형태로 기록됨
- 가스 비용 저렴(storage write에 비해서)
- indexed 키워드로 검색 최적화
- 컨트랙트 내에서 직접 접근 불가(off-chain 용도)

## Constructor
- 스마트 컨트랙트가 처음 배포될 때 딱 한 번 실행되는 함수
- 호출자: 배포자 (msg.sender)
- 상태 변수 초기화, 권한 설정

## Immutable
- 변수 선언 시 constructor에서 한 번만 설정 가능하고,
그 이후에는 절대 변경될 수 없는 변수를 만드는 키워드
