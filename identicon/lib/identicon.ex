defmodule Identicon do
  # @moduledoc """
  # Documentation for `Identicon`.
  # """

  # @doc """
  # Hello world.

  # ## Examples

  #     iex> Identicon.hello()
  #     :world

  # """
  # def hello do
  #   :world
  # end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |>:binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do # 이 라인에서는 Identicon.Image 구조체의 hex 키에 값이 할당되지 않는다.
    # 사용하고싶지 않은 변수를 포함해야할 때 변수명 앞에 언더스코어(_)를 붙인다
    # 패턴 매칭 작업을 함수 내에서 인수쪽으로 옮기면 가독성이 향상된다

    # [r, g, b]
    %Identicon.Image{image | color: {r, g, b}} # 이 라인에서 Identicon.Image 구조체의 hex 키에 값이 할당된다. image.color = {r, g, b} 처럼 쓰지 않는다
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1) # 함수에 대한 참조 전달 (그냥 함수 이름을 쓰면 참조가 전달되는 게 아니라 함수가 호출된다, &: 함수의 참조, /1: 같은 이름의 함수가 여러개 있는 경우 arity를 하나 받는 함수를 참조하길 원한단)
      |> List.flatten # List.flatten 함수를 쓰면 중첩된 반복문을 쓰지 않을 수 있다
      |> Enum.with_index

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first] # join 2 list
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0 # rem = room for remainders(나머지를 위한 공간)
      # 엘릭서에서 0은 false가 아니다
    end

    %Identicon.Image{image | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill) # Erlang 라이브러리에선 기존 데이터를 반환하기도 한다
    end

    :egd.render(image)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end
