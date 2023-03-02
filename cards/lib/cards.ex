defmodule Cards do
  @moduledoc """
    Documentation for `Cards`.

    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns Hello world.
  """

  def hello do
    "Hello World!"
  end

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Wrong
    # for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # Right 1
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)

    # Right 2
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Devides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  # 위의 Examples를 일부 수정하면 `mix test`로 테스트 실행 시 오류가 발생하는 걸 확인할 수 있다
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size) # 튜플 내 My Hand(인덱스 언제나 0), The Rest
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck) # 변수를 이진수 1, 0로 변환할 필요는 없지만, 파일시스템에 쓸 수 있는 형태(이진 객체)로는 변환(인코딩)해주어야 한다
    File.write(filename, binary)
  end

  # def load(filename) do
  #   {status, binary} = File.read(filename)

  #   case status do
  #     :ok -> :erlang.binary_to_term(binary)
  #     :error -> "That file does not exist"
  #   end
  # end

  def load(filename) do
    case File.read(filename) do # 한 줄의 코드에서 두 가지 별도 작업(비교, 할당)을 실행중이다
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist" # 사용하고싶지 않은 변수를 포함해야할 때 변수명 앞에 언더스코어(_)를 붙인다
    end
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
