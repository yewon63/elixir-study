# 1

- Official Github Repo
  - https://github.com/StephenGrider/ElixirCode
  - 한 브랜치가 한 챕터의 내용을 담고있어서 챕터 번호로 브랜치 검색하면 됨
- Diagrams
  - https://www.diagrams.net/

# 2

- 설치
  - `brew install elixir`

# 3

- (생략)

# 4

- `elixir`/`mix` 명령어가 실행되지 않으면 쉘 닫았다 다시 열어보기

# 5

- 책을 보거나 트윗을 볼 수도 있지만 가장 좋은 방법은 코드부터 작성해보는 것
- **엘릭서의 일반적인 설계 패턴, 테스트 방법, 문서 작성 방법**에 익숙해져야 함
- 프로젝트 설명
  - 특정 갬블링 게임 전체를 만드는 것이 아니라 한 벌의 카드를 처리할 때 발견되는 작업을 구현하는 것
  - UI 없이 CLI를 사용할 것
- 엘릭서는 함수형 프로그래밍 패러다임을 다름
  - <-> 자바스크립트, 파이썬, ... 에서 사용되는 객체지향 프로그래밍 패러다임과의 차이점을 계속 인식해야 함

# 6

- 엘릭서를 설치할 때 엘릭서 프로그래밍 언어 뿐만 아니라 각종 개발 도구도 함께 설치됨
- ex)
  - Mix
    - 엘릭서 생태계의 필수 요소
    - 기능
      - Creates Projects
      - Compiles Projects
      - Runs 'Tasks'
      - Manage Dependencies
    - 사용법
      - `mix new PATH`
        - Creates a new Elixir project at the given path
      - `cd PATH && mix test`
        - Move into Elixir project directory
        - Run test code

# 7

- `lib/PATH.ex`
  - `defmodule` 키워드이 있는 단일 코드 모듈을 정의함
- 모듈은 다양한 메서드나 함수의 모음임
- `mix new PATH` 에서 사용한 프로젝트 이름이 프로젝트 전체에서 사용됨 ex) `cards`
- `iex -S mix`
  - 프로젝트를 컴파일하고 엘릭서 쉘(엘릭서 대화형 쉘) 내에서 바로 사용할 수 있게 함
  - `iex -S SCRIPT`
    - Finds and executes the given script in $PATH
  - 메소드 호출 시 `()`(괄호)는 생략해도, 써도 잘 동작함
- 암시적 반환(Implicit Return)
  - 메서드나 함수가 실행될 때마다 해당 함수 내의 마지막 값을 자동으로 리턴한다.
  - `return` 키워드를 생략해도, 써도 잘 동작함

# 8

- 관례는 큰따옴표 사용
- 작은따옴표 지원함
- iex는 기본적으로 자동리프레시를 지원하지 않음
  - iex 명령어 실행중인 상태에서 `recompile` 입력하면 리프레시 할 수 있음
  - [https://hexdocs.pm/iex/IEx.Helpers.html#recompile/0](https://hexdocs.pm/iex/IEx.Helpers.html#recompile/0)

# 9

- `create_deck` 메서드를 작성할 때 `this.myDeck = {value}` 이런식으로 로컬 인스턴스 변수에 값을 할당하지 않았다.
  - 이게 객체 지향 프로그래밍과 함수형 프로그래밍의 중요한 차이점이다.
- 앞으로 엘릭서로 작성할 코드를 자바, 객체 지향 프로그래밍 기법을 사용해서 작성한다고 생각해보자
  - Card Class
    - this.suit
      - ex) Diamonds, Heart, ...
    - this.value
      - ex) 1, 2, ...
  - Deck Class
    - this.cards
      - ex) [<Card1>, <Card2>, ....]
    - shuffle
    - save
    - load
    - shuffle, save, load와 같은 각 메서드는 로컬 인스턴스 변수에서 작동한다.
- 똑같은 코드를 엘릭서로 작성한다고 생각해보자
  - 클래스, 클래스 인스턴스 같은 개념이 없다.
  - 모듈은 독립형 개체이며 인스턴스 변수(ex. this.cards, this.deck, ...)같은 건 없다.
  - 엘릭서에서의 모듈
    - standalone
    - can't create copy
      - 복사본을 만들 수 없다.
    - can't instantiate
      - 인스턴스화할 수 없다.
    - 메서드 모음일 뿐이다.
    - no instance variable
    - 따라서 덱을 만들거나 카드 모음을 만들고 싶을 때마다 `create_deck` 메서드를 호출하면 된다.
    - `shuffle` 같은 메서드를 호출할 땐 카드 배열을 전달하고 도로 반환받는다.
      - 인스턴스 변수가 없으므로
    - `save` 메서드를 호출한다고 값을 변수에 저장하지 않는다.
      - 유사한 문자열에 대한 참조 또는 저장 파일의 경로인 추정 문자열을 반환한다.
- Q: 왜 변수를 안쓰고 귀찮게 일일히 값을 반환받아야 할까?

# 10

- 함수형 프로그래밍에는 클래스나 클래스의 인스턴스, 인스턴스 변수 또는 이와 유사한 것도 없다.
- 엘릭서에서 새롭게 배우는 건 주로 패턴과 개념이다. 문법은 그다지 새롭지 않다.
- 이름이 같은 모듈 내부의 메서드를 가질 수 있다.
  - 다른 길이의 숫자, 다른 유형의 인수를 가질 수 있다.
  - ex) `Cards.shuffle/0`
    - 인수를 사용하지 않는다.
  - ex) `Cards.shuffle/1`
    - 인수 하나를 사용한다.

# 11

- arity
  - 함수가 받아들이는 인수의 수를 참조하는 방법이다.
- 리스트, 숫자, 파일시스템, HTTP 요청 등을 다루는 표준 라이브러리가 이미 다 있다.
- `Enum`같은 표준 라이브러리는 import가 따로 필요 없다.
- 공식 문서
  - [Enum](https://hexdocs.pm/elixir/Enum.html)
  - [Elixir](https://hexdocs.pm/elixir/Kernel.html)
  - [IEx](https://hexdocs.pm/iex/IEx.html)
  - [Mix](https://hexdocs.pm/mix/Mix.html)

# 12

- Immutability(불변성)
  - 엘릭서는 절대 기존 데이터 구조를 수정하지 않는다. 새로운 데이터 구조를 반환한다.
  - shuffle 메서드만 하더라도 기존 리스트 내부 값들을 섞어서 주는 게 아니라 기존 리스트를 복사해서 값을 섞고 반환해주는 거다.


```elixir
iex(12)> deck2
["Ace", "Two", "Three", "Four"]
iex(13)> Cards.shuffle(deck2)
["Three", "Four", "Two", "Ace"]
iex(14)> deck2
["Ace", "Two", "Three", "Four"] # 엘릭서는 기존 데이터 구조를 수정하지 않는다.
```

# 13

- 엘릭서 메서드 이름에 물음표(?)를 쓸 수 있다.
  - ex) `contains?`
  - 관례상 메서드 이름에 물음표가 있으면 부울 값(true/false)을 반환한다.
- 리스트에 어떤 값이 포함되어 있는지 여부를 파악하기 위해 `deck.indexOf()` 이런식으로 메서드를 호출한다. 엘릭서는 왜 아예 다르게 `Enum.member?(deck, cards)` 이런식으로 처리할까?
  - 몇 가지 큰 마스터 메서드를 가지고 있고, 몇 가지 인수를 전달한다. 표준 라이브러리에 위임하고 있다.

# 14

- list comprehension (리스트 이해)
  - 이 구문은 mappping(매핑) 기능이 있다.
  - 리스트를 순환하면서 새로운 데이터 구조에 값을 하나씩 넣는다.
    - 단순히 순환만 하는 게 아니라 순환 + 변환한다.

```elixir
iex(25)> Cards.create_deck()
["Spades", "Clubs", "Hearts", "Diamonds"]
iex(26)> recompile
Compiling 1 file (.ex)
warning: variable "suit" is unused (if the variable is not meant to be used, prefix it with an underscore)
  lib/cards.ex:24: Cards.create_deck/0

warning: variable "values" is unused (if the variable is not meant to be used, prefix it with an underscore)
  lib/cards.ex:21: Cards.create_deck/0

:ok
iex(27)> Cards.create_deck()
["Is this a map?", "Is this a map?", "Is this a map?", "Is this a map?"]
```

# 15
- 중첩 list comprehension

    ```elixir
    iex(29)> Cards.create_deck()
    [
      ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds"],
      ["Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds"],
      ["Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds"],
      ["Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds"],
      ["Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]
    ]
    ```

  - 의도
    - 1차원 리스트를 반환한다.
  - 문제
    - 2차원 리스트를 반환한다.

- 템플릿 문자열(Template Strings) / 문자열 보간(String Interpolation)

    ```elixir
    "#{value} of #{suit}"
    ```

# 16
- 엘릭서의 리스트는 배열(Array)이 아니라 연결리스트(Linked List)다.
- `List.flatten(list)`
  - 표준 라이브러리를 아는 것은 매우 중요하다.

    ```elixir
    iex(33)> Cards.create_deck()
    ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
    "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
    "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
    "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
    "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
    ```

# 17
- `Enum.split(enumerable, count)`

  ```elixir
  iex(36)> Cards.deal(deck, 2)
  {["Ace of Spades", "Two of Spades"],
  ["Three of Spades", "Four of Spades", "Five of Spades", "Ace of Clubs",
    "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs",
    "Ace of Hearts", "Two of Hearts", "Three of Hearts", "Four of Hearts",
    "Five of Hearts", "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds",
    "Four of Diamonds", "Five of Diamonds"]}
  ```

- 튜플
  - 각 인덱스가 매우 특별한 의미를 갖는 배열
  - 자바스크립트 object처럼 key-value 쌍을 사용하는 대신 첫 번째 인덱스는 My Hand를 가리키고, 두 번째 인덱스는 The Rest를 가리킨다.
  - 리스트와의 차이점
    - 리스트는 유사한 레코드 모음을 위한 데이터 구조다.
    - 튜플은 완전히 다른 유형의 항목일 수 있지만 순서는 일부 의미를 지정한다.