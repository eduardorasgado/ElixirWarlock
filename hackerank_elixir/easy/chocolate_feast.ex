defmodule Solution do
  @moduledoc """
  Chocolate feast problem
  Can found the problem explanation on:
    https://www.hackerrank.com/challenges/chocolate-feast/problem
  """

  def get_test_amount do
    IO.gets("") |> String.strip |> String.to_integer
  end

  # Represents the algorithm to solve the problem
  # n = money to spend
  # c = chocolate value
  # m = wrappers needed to change
  defp solution([n, c, m, bar_amount]) do
    cond do
      n > 0 && n >= c ->
        solution([n-1, c, m, bar_amount + 1])
      true -> bar_amount
    end
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
  def main_dev(list) do
    solution(list ++ [ 0 ]) |> IO.puts
  end
end
# hackerrank main
#Solution.main()

# correct: 3
Solution.main_dev([7, 3, 2])
# correct: 6
Solution.main_dev([10, 2, 5])
# correct: 3
Solution.main_dev([12, 4, 4])
# correct: 5
Solution.main_dev([6, 2, 2])
