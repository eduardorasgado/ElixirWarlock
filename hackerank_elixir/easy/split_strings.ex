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
    str = str_s
    |> String.split("")
    |> Enum.filter(fn(x) -> x !="" end)


    str_odd = str |> Enum.count |> rem(2) != 0

    str_chunked = str
     |> Enum.chunk_every(2)

    cond do
      str_odd ->
        [a] = Enum.at(str_chunked, -1)
        pair_list_builder List.replace_at(str_chunked, -1, [a, "_"])
      true ->
        pair_list_builder str_chunked
    end
  end

  def pair_list_builder str_chunked do
    Enum.map(str_chunked, fn([a, b]) ->
      "#{a}#{b}"
    end)
  end
end


IO.inspect SplitStrings.solution("abc")
IO.inspect SplitStrings.solution("abcdef")
