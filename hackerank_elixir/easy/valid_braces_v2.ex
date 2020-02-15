defmodule Challenge do
  @moduledoc """
  Problems can be find here:
    https://www.codewars.com/kata/5277c8a221e209d3f6000b56
  """

  @doc """
    The logic of the algorithm is to match a token ["(", "{", "["]
    with a validate function given the tail that contains [")", "}", "]"]

    if all curly braces get closed then at the end we will expect a [], [] head | tail and tokens arguments
    if not all curly braces get closed or opened then we will expect [elements within], [not a token elements]
    and the elements within the head | tail list do not match any pattern in function 3
  """
  def valid_braces(braces) do
    braces
    |> String.codepoints
    |> validate([])
  end

  # substract tail ")", and head "(" and tokens, returns new validation with all elements but those simbols within
  defp validate([")" | tail ], [ "(" | tokens]), do: validate(tail, tokens)
  defp validate(["}" | tail], ["{" | tokens]), do: validate(tail, tokens)
  defp validate(["]" | tail], ["[" | tokens]), do: validate(tail, tokens)

  # brace matcher main validate function
  defp validate([head |tail], tokens) when head in ["(", "{", "["] do
    IO.puts "head is: #{head}"
    IO.inspect tail
    validate(tail, [head | tokens])
  end

  defp validate([], []), do: true
  defp validate(_, _), do: false
end

IO.puts("----------")
IO.inspect Challenge.valid_braces("(){}[]")
IO.puts("----------")
IO.inspect Challenge.valid_braces("([{}])")
IO.puts("----------")
IO.inspect Challenge.valid_braces("(}")
IO.puts("----------")
IO.inspect Challenge.valid_braces("[(])")
IO.puts("----------")
IO.inspect Challenge.valid_braces("[({})](]")
IO.puts("----------")
# true
# (1 (2 {3 {4 [5 [6 ]7 ]8 }9 }10 )11 )12
IO.inspect Challenge.valid_braces("(({{[[]]}}))")
IO.puts("----------")
# true
IO.inspect Challenge.valid_braces("{}[]{}(){}")
IO.puts("----------")
# false
IO.inspect Challenge.valid_braces(")(}{][")
