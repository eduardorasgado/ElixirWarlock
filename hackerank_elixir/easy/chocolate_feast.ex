defmodule Solution do
  @moduledoc """
  Chocolate feast problem
  Can found the problem explanation on:
    https://www.hackerrank.com/challenges/chocolate-feast/problem
  """

  def get_test_amount do
    IO.gets("") |> String.strip |> String.to_integer
  end
  @doc """
  Represents the algorithm to solve the problem
  """
  defp solution() do

  end

  @doc """
  Main func for hackerank
  Get the t entry from the user
  """
  def main do

    1..get_test_amount() |> Enum.each(fn(_element) ->
      [n, c, m] = IO.gets("") |> String.strip |> String.split(" ")
      IO.puts n
    end)
  end

  @doc """
  Main function for dev environment
  """
  def main_dev([n, c, m]) do
    IO.inspect n
  end
end
# hackerrank main
#Solution.main()


Solution.main([7, 3, 2])
