defmodule Solution do
  @moduledoc """
  This problem can be found in next link:
    https://www.hackerrank.com/challenges/halloween-sale/problem
  """
  # Enter your code here. Read input from STDIN. Print output to STDOUT
  defp solution(list) do
    # p = initial cost
    # d = intervals down cost
    # m = min cost
    # s = money we have
    # [ p, d, m, s ] = list
    list =
      Enum.map(list, fn element ->
        element |> String.to_integer()
      end)

    buy(list ++ [0])
  end

  defp buy([p, d, m, s, amount]) do
    IO.puts("#{p}, #{d}, #{m}, #{s}, #{amount}")

    cond do
      s >= p ->
        amount = amount + 1
        # if cost has not arrived to minimun cost
        s_new = s - p

        if p > m do
          buy([p - d, d, m, s_new, amount])
        else
          buy([m, d, m, s_new, amount])
        end

      s < p ->
        IO.puts("#{p}, #{d}, #{m}, #{s}, #{amount}")
        amount
    end
  end

  def main(list) do
    list = list |> String.strip() |> String.split(" ")
    "The result is #{solution(list)}" |> IO.puts()
  end
end

# input = String.gets
# solution is 6
Solution.main("20 3 6 80")
# correct is 7
Solution.main("20 3 6 85")
