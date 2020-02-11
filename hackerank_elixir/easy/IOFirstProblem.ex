defmodule Solution do
  @moduledoc """
  This problem can be found here:
    https://www.hackerrank.com/challenges/fp-solve-me-first/problem
  """
  def main do
    a = IO.gets("") |> String.strip |> String.to_integer
    b = IO.gets("") |> String.strip |> String.to_integer
    IO.puts a + b
  end
end

Solution.main()
