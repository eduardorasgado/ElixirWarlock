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

    [ p, d, m, s ] = list
    if m < p do
      buy(list ++ [0])
    else
      0
    end
  end

  defp buy([p, d, m, s, amount]) do
    IO.puts("#{p}, #{d}, #{m}, #{s}, #{amount}")

    cond do
      s >= p ->
        amount = amount + 1
        # if cost has not arrived to minimun cost
        s_new = s - p
        # 2 possible corner cases:
        # p - d should not be less than zero
        # p - d should be greater or equals to m
        if p > m && p - d > 0 && p - d >= m do
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
# correct is 29
Solution.main("89 91 26 840")
# correct is 128
Solution.main("93 39 74 9553")
