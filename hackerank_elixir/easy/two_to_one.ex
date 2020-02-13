defmodule TwoToOne do
  @moduledoc """
  Can be found here:
  https://www.codewars.com/kata/5656b6906de340bd1b0000ac/train/elixir

  Take 2 strings s1 and s2 including only letters from ato z.
  Return a new sorted string, the longest possible, containing distinct letters,

    each taken only once - coming from s1 or s2.

  """
  def longest(a, b) do
    # Put your code here
    "#{a}#{b}" |> String.codepoints |> Enum.uniq |> Enum.sort |> Enum.join
  end
end

a = "xyaabbbccccdefww"
b = "xxxxyyyyabklmopq"
#correct: "abcdefklmopqwxy"
IO.inspect TwoToOne.longest(a, b)

a = "abcdefghijklmnopqrstuvwxyz"
#correct: "abcdefghijklmnopqrstuvwxyz"
IO.inspect TwoToOne.longest(a, a)
