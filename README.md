# swift-chess-app
스위프트 체스게임 앱 (클린 스위프트 첫번째 과제)

<br><br>

# 구조도

![image](https://user-images.githubusercontent.com/62230118/222966211-c0f90ca5-da60-495d-94d9-ab49c49fb30d.png)

<br><br>

# 객체 설명

### Piece

- 말의 부모 객체
- 주요 기능
    - 초기화 가능한 위치 데이터 제공
    - 이동할 수 있는 위치 데이터 제공

### Pawn, Queen, Rook, King, Knight, Bishop

- 세부 특성에 따른 ‘초기화 가능 위치’, ‘이동할 수 있는 위치’에 관한 세부 구현
- ex) Rook(블랙)은 A1, H1 에 초기화 가능, 상하좌우 직선으로 이동가능

### Board

- chess말들의 위치 정보를 가지고 있는 matrix 변수
- 체스말들의 초기화 가능 여부 판단 및 초기화
- 체스말들의 이동 가능 여부 판단 및 이동
    - 체스말들이 가지고 있는 이동 가능한 위치 데이터와 보드에 있는 다른 말들의 위치를 고려해서 판단

### BoardMatrix

- Board의 matrix를 순회하는 처리를 대신 해주는 Util 객체

### ChessGame

- 비지니스 로직을 담당 (일종의 ViewModel)
- ViewController에서 받은 입력값을 바탕으로 로직 처리 후 board 상태 변경 및 view 변화를 위한 명령 전달

### ViewController

- ChessGame과 View들을 연결

### BoardView

- 보드를 표현하는 View
- delegate를 통해 선택된 position을 ViewController에게 전달

<br><br>

# 배운 것

- 분기가 있다는 건 더 추상화할 여지가 있다는 것이다.
- 객체를 만들때 역할을 더 작게 나누고 역할을 조정해보자.
- model의 위치도 한번 더 고민하자. 전역으로 선언해야할지, 클래스에 종속되게 선언할지. 네임스페이스를 활용해 그룹핑하는 것도 좋은 방법이다.
- 체스판의 index를 관리하기 힘들면 enum으로 관리할 수도 있다.
- 나의 코드와 설계 의도를 말로 설명하는 연습을 하자. 코드는 더 명확해질 것이고 피드백을 통해서 더욱 개선될 것이다.

<br><br>


