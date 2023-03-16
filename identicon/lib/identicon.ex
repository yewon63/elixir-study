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
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |>:binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do # 사용하고싶지 않은 변수를 포함해야할 때 변수명 앞에 언더스코어(_)를 붙인다
    # 패턴 매칭 작업을 함수 내에서 인수쪽으로 옮기면 가독성이 향상된다

    # [r, g, b]
    %Identicon.Image{image | color: {r, g, b}} # image.color = {r, g, b} 처럼 쓰지 않는다
  end
end
