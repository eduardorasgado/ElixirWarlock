defmodule SplitStrings do
  @moduledoc """
  This problem can be found here:
    https://www.codewars.com/kata/515de9ae9dcfc28eb6000001/train/elixir
  """
  @doc """
  solution("abc") # should return ["ab", "c_"]
  solution("abcdef") # should return ["ab", "cd", "ef"]
  """
  def solution(str_s) do
    # Your code here
    str_s <> "_"
    |> String.graphemes
    |> Enum.chunk(2, 2, :discard)
    |> Enum.map(&Enum.join/1)
  end
end


IO.inspect SplitStrings.solution("abc")
IO.inspect SplitStrings.solution("abcdef")
