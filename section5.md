# 35, 36, 37, 38

- `mix new identicon`
- Github 같은 사이트에서 프로필사진을 지정하지 않았을 때 임의로 생성되어서 지정되는 이미지를 identicon이라고 함
- 5x5 그리드(격자무늬), 250x250 크기, 한 픽셀은 5x5 크기, 디자인은 중앙세로선을 기준으로 데칼코마니
- 디자인은 랜덤으로 생성되지 않고, 동일한 문자를 입력하면 언제나 동일한 결과를 반환해야 함
- String(Input) -> Identicon Generator -> Image(Save -> Output)
- 과정
  1. String(Input)을 일련의 함수에 전달함

       - `Compute MD5 hash of string`
       - `List of numbers based on the string`
       - `Pick color`
       - `Build grid of squares`
       - `Convert grid into image`
       - `Save image`

  2. Image(Output)을 반환함
- 문자열을 해싱한 값(해시값)으로 색을 선택함

# 39

- 입력을 받아서 고유한 문자 시퀀스를 반환하는 방법
  - 해싱함수의 내부 동작에 대해 너무 신경쓰지 말 것

```elixir
iex(1)> hash = :crypto.hash(:md5, "banana")
<<114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65>>
iex(2)> Base.encode16(hash)
"72B302BF297A228A75730123EFEF7C41"
iex(3)> :binary.bin_to_list(hash) # 해싱함수의 내부 동작보다 이게 중요하다
[114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]
```

```elixir
iex(1)> Identicon.main("banana")
[114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]


# 40

- `Identicon.hash_input`에서 반환된 숫자 리스트 내부 값을 3개씩 묶어서 각각 R, G, B 값으로 바꾸면 숫자에서 색상을 뽑을 수 있다.
- 어떻게 값 3개로 5칸의 색상을, 중앙세로선을 기준으로 데칼코마니가 되도록 얻을 수 있나?
  - ex)
    - input: [145, 46, 200]
    - output: [145, 46, 200, 46, 145]
  - 홀수면 색칠하고, 짝수면 색칠하지 않음
