# 32

- 두 가지 데이터 구조
  - Map
  - Keyword List

## Map ([Link](https://hexdocs.pm/elixir/1.12/Map.html))

```elixir
iex(1)> colors = %{primary: "red"}
%{primary: "red"}
iex(2)> colors.primary
"red"
```

```elixir
iex(3)> colors = %{primary: "red", secondary: "blue"} 
%{primary: "red", secondary: "blue"}
iex(4)> colors.secondary
"blue"
```

```elixir
# 패턴 매칭
iex(5)> %{secondary: secondary_color} = colors
%{primary: "red", secondary: "blue"}
iex(6)> secondary_color
"blue"
```

# 33

## Update Maps

- 엘릭서에서는 데이터 구조를 변경하지 않고, 아예 새로운 데이터 구조를 만든다.
- 키 이름은 `""`(따옴표)가 아니라 `:`(콜론)과 함께 쓴다.
  - `"primary"` -> X
  - `:primary` -> O

```elixir
# Wrong
iex(7)> colors.primary = "blue"
** (CompileError) iex:7: cannot invoke remote function colors.primary/0 inside a match
    (elixir 1.14.3) src/elixir_clauses.erl:23: :elixir_clauses.match/5
    (elixir 1.14.3) src/elixir_expand.erl:11: :elixir_expand.expand/3
    (elixir 1.14.3) src/elixir.erl:376: :elixir.quoted_to_erl/4
    (elixir 1.14.3) src/elixir.erl:277: :elixir.eval_forms/4
    (elixir 1.14.3) lib/module/parallel_checker.ex:110: Module.ParallelChecker.verify/1
    (iex 1.14.3) lib/iex/evaluator.ex:329: IEx.Evaluator.eval_and_inspect/3
    (iex 1.14.3) lib/iex/evaluator.ex:303: IEx.Evaluator.eval_and_inspect_parsed/3
```

```elixir
# Right 1 (Map.put 함수로 기존 속성 업데이트 가능)
iex(2)> colors = %{primary: "red", secondary: "blue"} 
%{primary: "red", secondary: "blue"}
iex(9)> Map.put(colors, :primary, "blue")   
%{primary: "blue", secondary: "blue"}
```

```elixir
# Right 2 (파이프 연산자는 기존 속성을 업데이트할 때만 사용가능)
iex(4)> %{ colors | primary: "blue2" }
%{primary: "blue2", secondary: "blue"}
iex(5)> colors.primary
"red"
```

```elixir
# 파이프 연산자로 새로운 속성 추가 X
iex(6)> %{ colors | others: "blue3" } 
** (KeyError) key :others not found in: %{primary: "red", secondary: "blue"}
    (stdlib 4.2) :maps.update(:others, "blue3", %{primary: "red", secondary: "blue"})
    (stdlib 4.2) erl_eval.erl:309: anonymous fn/2 in :erl_eval.expr/6
    (stdlib 4.2) lists.erl:1350: :lists.foldl/3
    (stdlib 4.2) erl_eval.erl:306: :erl_eval.expr/6
    (elixir 1.14.3) src/elixir.erl:294: :elixir.eval_forms/4
    (elixir 1.14.3) lib/module/parallel_checker.ex:110: Module.ParallelChecker.verify/1
    (iex 1.14.3) lib/iex/evaluator.ex:329: IEx.Evaluator.eval_and_inspect/3
    (iex 1.14.3) lib/iex/evaluator.ex:303: IEx.Evaluator.eval_and_inspect_parsed/3
```

```elixir
# Map.put 함수로 새로운 속성 추가 O
iex(1)> colors = %{primary: "red", secondary: "blue"} 
%{primary: "red", secondary: "blue"}
iex(2)> Map.put(colors, :others, "others")
%{others: "others", primary: "red", secondary: "blue"}
iex(3)> colors.others
** (KeyError) key :others not found in: %{primary: "red", secondary: "blue"}
    iex:3: (file)
iex(3)> colors2 = Map.put(colors, :others, "others")
%{others: "others", primary: "red", secondary: "blue"}
iex(4)> colors2.others
"others"
```

# 34

## Keyword List

- Key-Value 쌍으로 보이지만 엘릭서는 이를 튜플로 간주한다.


```elixir
iex(1)> colors = [{:primary, "red"}, {:secondary, "green"}]
[primary: "red", secondary: "green"]
iex(2)> colors[:primary]
"red"
iex(3)> colors.primary 
** (KeyError) key :primary not found in: [primary: "red", secondary: "green"]. If you are using the dot syntax, such as map.field, make sure the left-hand side of the dot is a map
    iex:3: (file)
```

```elixir
iex(3)> colors2 = [primary: "red", secondary: "blue"]
[primary: "red", secondary: "blue"]
iex(4)> colors2[:primary]
"red"
iex(5)> colors2.primary
** (KeyError) key :primary not found in: [primary: "red", secondary: "blue"]. If you are using the dot syntax, such as map.field, make sure the left-hand side of the dot is a map
    iex:5: (file)
```

맵을 사용하면 한 개의 맵에 대해 같은 속성 타입은 하나만 가질 수 있다. 키워드 리스트는 같은 속성 타입을 여러개 가질 수 있다.

ex) Ecto 라이브러리로 Database Query를 작성하는 경우 `where`절을 여러번 작성할 수 있다.

```elixir
iex(6)> colors = %{primary: "red", primary: "blue"}         
warning: key :primary will be overridden in map
  iex:6

%{primary: "blue"}
iex(7)> colors = [primary: "red", primary: "blue"]
[primary: "red", primary: "blue"]
```
