# 41

## Struct (구조체, [Link](http://elixir-ko.github.io/getting_started/15.html))

- 맵의 확장판인 데이터 구조
- 기본값을 할당할 수 있고, 컴파일 시간 확인 기능도 있다.
- `defstruct` 키워드로 구조체를 정의할 수 있다.
- 많은 정보를 인수로 전달할 때 긴 리스트로 전달할 수도 있지만, 구조체로 전달하는 게 더 나은 방법이다.
  - 구조체에 애플리케이션 내 모든 데이터를 갖고있을 수 있다.
- 다른 언어에서 클래스에 메서드를 추가하던 것처럼 구조체에 함수를 추가할 수 있다고 생각할 수도 있다.
  - 하지만 엘릭서는 함수형 프로그래밍 언어다. 구조체에 함수를 연결할 수 없다. 원시 데이터만 보관할 수 있다.

```elixir
iex(1)> %Identicon.Image{}
%Identicon.Image{hex: nil}

iex(2)> %Identicon.Image{hex: []}
%Identicon.Image{hex: []}

iex(3)> %Identicon.Image{oct: []} # 구조체에 미리 정의한 속성만 사용할 수 있다
** (KeyError) key :oct not found
    (identicon 0.1.0) expanding struct: Identicon.Image.__struct__/1
    iex:3: (file)
```

```elixir
iex(1)> Identicon.main("asdf")
%Identicon.Image{
  hex: [145, 46, 200, 3, 178, 206, 73, 228, 165, 65, 6, 141, 73, 90, 181, 112]
}
```

# 42

# 43
