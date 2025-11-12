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

# $$Ethereum$$

## 창시 동기
비트코인이 블록체인의 잠재력을 완전히 활용하지 못하며 , 중앙화된 플랫폼 독점을 탈피하여 영구적인 개인 데이터 소유권 을 구현하려는 목적에서 출발

## 핵심 혁신
비트코인의 화폐 기능에 튜링 완전성(Turing-Completeness) 을 갖춘 스마트 컨트랙트 기능을 추가

## 개발 언어
객체지향 및 정적 타입 언어인 솔리디티(Solidity) 가 EVM을 타겟으로  설계

## World Computer
- programmable blockchain: 사용자가 복잡성을 직접 프로그래밍할 수 있는 퍼블릭 블록체인
- State Consensus: 트워크의 모든 노드가 EVM을 통해 동일한 연산을 수행함으로써 동일한 전역 상태(state)에 합의하는 아키텍처

## The Merge
기존의 작업증명(PoW)에서 지분증명(PoS) 컨센서스 알고리즘으로 전환

## Distributed Computing
- transaction based state machine: 현재 상태는 오직 트랜잭션의 실행을 통해서만 다음 상태로 전이
- 데이터 중복성: 모든 노드가 코드 및 데이터 전체의 복사본을 가지며 상호 연결되어 중앙 권한 이나 제3자의 간섭 없이  애플리케이션 실행을 보장

## DApp Architecture
- Client-side
1. Dapp Web Browser를 통해 DApp과 상호작용
2. HTML/CSS/Javascript로 구성되며, 핵심적으로 Web3.js라이브러리(자바스크립트가 이더리움 블록체인과 통신할 수 있도록 하는 핵심 인터페이스)를 포함
- RPC
1. 프론트엔드(Web3.js)는 RPC 통신을 통해 로컬 또는 원격 이더리움 노드에 연결
2. DApp이 블록체인에 데이터를 읽거나(Read) 트랜잭션을 전송(Write)하는 표준 통신 규약
- Decentralized Server
1. 전통적인 아키텍처(Web2)의 "database/cache and server code" 를 EVM과 블록체인이 대체
2. EVM (Ethereum Virtual Machine): 스마트 컨트랙트가 실행되는 런타임 환경입니다. DApp의 비즈니스 로직(Logic)을 처리
3. Blockchain: 모든 트랜잭션과 컨트랙트의 상태(State)가 영구적으로 저장되는 분산 원장(데이터베이스)
- Limitation
1. 이 모델에서 DApp과 상호작용을 원하는 모든 사용자는 이더리움 풀 노드(Full Node)를 직접 운영해야함
2. 막대한 저장 공간과 컴퓨팅 자원을 요구하므로 일반 사용자에게는 비현실적
--> 제3자에 대한 신뢰가 전혀 필요 없는 '완전한 비신뢰(Trustless)' 환경을 구현
- Solution
1. Hosted Nodes: Infura, Alchemy와 같은 노드 제공자(Node Provider)가 풀 노드를 운영하고, 개발자에게 RPC 엔드포인트를 서비스로 제공
2. MetaMask: 브라우저 지갑(복잡성을 추상화하는 핵심 도구)
--> 사용자는 풀 노드를 직접 운영하지 않고도 DApp과 상호작용

## DApp의 3가지 핵심 요소
- Database(Blockchain): 네트워크의 모든 트랜잭션을 저장하는 불변의 DB
- Code(Solidity): 애플리케이션의 비즈니스 로직(스마트 컨트랙트)
- EVM 코드를 EVM이 실행할 수 있는 저수준의 바이트코드(Bytecode)로 컴파일하며, 이 바이트코드를 블록체인에 배포

<br><br><br><br><br>

# $$EVM$$

## Def
- 스마트 컨트랙트의 배포와 실행을 담당하는 런타임 환경(Runtime Environment)
- transaction-based state machine: 이더리움의 전역 상태(모든 계정 잔액, 컨트랙트 스토리지 등)가 오직 트랜잭션의 실행을 통해서만 다음 상태로 전이(transition)될 수 있음
- EVM은 바로 상태 전이를 계산하고 실행하는 엔진

## Architecture
- Sandbox: 실행 중인 스마트 컨트랙트가 EVM 외부의 네트워크, 파일 시스템 또는 다른 프로세스에 "접근하지 않는다" 는 것을 의미
- Stack-based Machine: 솔리디티 코드가 컴파일되면 "바이트코드" 가 생성되며, EVM은 이 바이트코드를 순차적으로 처리

## Purpose
- Deterministic Execution: 
- Distributed Consensus: 
- State Veify: 

## Execution Lifecycle
- Compile: 솔리디티(Solidity) 같은 고수준 언어로 코드를 작성하면, 컴파일러는 이를 EVM이 이해할 수 있는 EVM 바이트코드(Bytecode)로 변환
- Deploy: 랜잭션을 통해 이더리움 블록체인에 배포
- Execute: 트랜잭션을 통해 특정 컨트랙트의 함수를 호출하면, 네트워크의 모든 노드는 해당 컨트랙트의 바이트코드를 EVM에서 실행
- Opcode 처리: 바이트코드를 "작업(operation)" 단위로 읽어 들임
- Excution Loop: 프로그램 카운터(PC)를 0부터 시작하여, Opcode를 하나씩 반복적으로 수행(명시적 종료 명령을 만나거나, 오류가 발생할 때 까지)
- Gas: 모든 Opcode 미리 정의된 가스 비용을 가지며, EVM은 명령을 실행할 때마다 트랜잭션 발신자가 지불한 가스에서 해당 비용을 차감

## Data 
- Storage: 컨트랙트의 장기 저장소이자 영구적인 키/값 저장소(컨트랙트의 '상태(State)'를 저장하는 유일한 비휘발성 공간)
- Memory: 임시(휘발성) 저장 공간(복잡한 데이터 처리(예: 함수 내 연산, 다른 컨트랙트 호출 시 인자 전달)에 사용)
- Stack: 연산을 수행하기 위한 가장 기본적인 임시 공간(실행이 끝나면 사라)

## ABI(Application Binary Interface)
- JSON 형식으로 정의
- EVM 외부의 애플리케이션이 컨트랙트의 함수를 호출하고 데이터를 다시 가져오는 법에 대한 표준 체계를 정의한 인터페이스
- 함수 호출을 EVM이 이해할 수 있는 저수준 바이트코드(트랜잭션 데이터)로 어떻게 인코딩(encoding)하고, EVM이 반환한 결과를 어떻게 디코딩(decoding)할지 알려주는 통신 규약

<br><br><br><br><br>

# $$Solidity$$

## 정의
이더리움이 제공하는 스마트 컨트랙트용 **정적 타입(Statically-typed)** 고급 언어.  
C++ / JavaScript / Python의 영향을 받음

## 실행 환경
- **EVM (Ethereum Virtual Machine)** 위에서 동작

# $$Variable$$

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
- 모든 인스턴스가 동일

## Immutable
- 변수 선언 시 constructor에서 한 번만 설정 가능하고,
그 이후에는 절대 변경될 수 없는 변수를 만드는 키워드
- 생성자에서 인스턴스별로 확정

## Abstraction
- 각 객체에 대해 시스템에서 반드시 필요한 상태(state)와 행위(behavior)를
추출하는 것
- 중요하거나 관심있는 부분만 포함하여 표현 
- 동일한 대상에 대해 관점(perspective)에 따라 abstraction 결과가 달라짐
- 유무형의 모든 것들이 객체로 abstraction 가능함
- Class: A definition of a set of objects with similar
- Object(Instance): has instantized states and behaviors(All objects are instances of some class)
- abstract contract
- interface

## Inheritance
- 기존에 정의된 계약(부모/상위)의 코드와 기능을 새로운 계약(자식/하위)이 물려받는 것
- 코드 재사용, 기능 확장, 다형성(polymorphism) 구현
- Child는 Parent의 모든 public 및 internal 함수, 상태변수를 자동 상속
- private은 상속되지 않음
- 부모 컨트랙트가 생성자 constructor를 가지고 있다면, 자식 컨트랙트는 생성자에서 명시적으로 호출해줘야 함

## Encapsulation
- 객체의 데이터(상태)와 동작(메서드)를 하나의 단위(객체)로 묶고, 외부에서의 직접 접근을 제한하며, 오직 허용된 인터페이스(함수)를 통해서만 접근하도록 만드는 원칙 
- 객체 지향의 가장 핵심적인 개념
- Visibility Modifiers(private, internal, public, external)를 통해서 구현
- 무결성 유지: 상태변수를 마음대로 수정 못 하도록 제한
- 유지보수성 향상: 인터페이스만 신경 쓰면 되므로 내부 구현 자유롭게 변경 가능
- 보안 강화: 외부에서 상태를 훼손하지 못하게 차단
- 상태 변수는 기본적으로 private 또는 internal로 설정
- 함수 접근 제어는 onlyOwner, require(...) 같은 접근 제한자(Access Control) 와 결합
- 최소화: 외부에서 필요한 기능만 공개, 나머지는 모두 숨김
- 무변경: 외부에 공개되는 부분은 향후 변경되지 않도록 최대한 일반화해서 정의함
- 각 object가 모듈(module)화 되어 독립적으로 구현될 수 있으므로 코드
간의 의존성이 획기적으로 감소

## Polymorphism
- 같은 함수 이름이지만, 다른 컨트랙트나 타입에서 다른 방식으로 동작할 수 있도록 허용
- one interface, multiple implementations
- operation overriding(inheritance) + dynamic binding을 통해 구현
- Class 차원의 encapsulation을 구현한 구조
- Superclass가 subclass들을 encapsulation함 
- 부모 타입으로 선언된 참조가 자식 인스턴스를 가리킬 수 있음(반대는 불가능)

## Overriding
- 부모의 기능을 자식이 재정의
- 다형성(Polymorphism)을 구현하고, 이는 동적 디스패치(Dynamic Dispatch)를 통해 이루어짐
- 실행 시점(Runtime)에 어떤 함수를 호출할지 결정하여 코드의 유연성과 확장성을 극대화
- 부모 컨트랙트 타입으로 선언된 변수가 실제로는 자식 컨트랙트 인스턴스를 가리킬 때, 해당 자식 컨트랙트에서 재정의된 함수를 정확히 호출
- Parameters, Return Values: 반드시 동일
- Visibility Specifiers: 같거나 더 넓게(private < internal < public)
- Mutability Specifiers: 같거나 더 엄격하게(payable<non-payable<view<pure)

## Overloading
- 함수 이름은 같지만 파라미터(매개변수)의 개수나 타입을 다르게 해서 여러 버전의 함수를 만드는 것
- 함수 선택자(Function Selector)이며, 이는 정적 디스패치(Static Dispatch)를 통해 이루어짐
- 어떤 함수를 호출할지는 컴파일 시점(Compile-time)에 결정
- Return Values는 구분 기준으로 사용되지 않음(Parameters는 같은데 Return Values만 다르다면 오버로딩이 아님)
- Visibility, Mutability Specifiers: 독립적(제약없음)

## Abctract Contract
- 미완성된 설계도
- 하나 이상의 함수가 구현되지 않았을 경우: 함수 시그니처만 선언되고 {}로 된 함수 본문이 없는 함수가 하나라도 있으면 그 컨트랙트는 자동으로 추상이됨
- abstract 키워드를 명시적으로 사용한 경우(모든 함수가 구현되었더라도)
- 직접 배포 불가
- 상속을 통한 완성 자식 컨트랙트는 부모인 추상 컨트랙트의 모든 미구현 함수들을 반드시 구현(override)해야함

## Interface
- 컨트랙트가 외부에 제공해야 할 함수의 집합을 정의
- 모든 함수는 미구현 상태여야함
- 모든 함수는 반드시 external이어야함
- 상태 변수를 선언할 수 없음
- 생성자(Constructor)를 가질 수 없음
- 다른 컨트랙트를 상속할 수 없음
- 표준화 (Standardization): 동일한 방식으로 상호작용할 수 있게 해줌
- 컨트랙트 상호작용: 컨트랙트의 전체 소스 코드를 알 필요 없이 인터페이스와 주소만 있으면 상호작용 가능
- 컨트랙트 간의 Loose Coupling을 가능하게 하는 핵심 도구

## Exception Handling

### 1. Assert
- 개발자 자신의 코드에 있는 치명적인 버그를 찾아내기 위한 최후의 안전장치
- 함수 실행 중 불변 조건(invariant)이 깨졌는지를 확인하기 위해 사용
- 내부 상태의 일관성과 코드의 무결성을 검증
- assert의 조건이 false가 되면, EVM은 INVALID Opcode를 실행(해당 트랜잭션에 남아있는 모든 가스가 소모)하고 모든 상태 변경은 원상 복구됨
- 논리적으로 절대 도달해서는 안 되는 코드 블록에 assert(false)를 넣어 안전장치를 마련