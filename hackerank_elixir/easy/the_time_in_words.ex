defmodule Solution do
  @moduledoc """
  This exercise can be found in:
    https://www.hackerrank.com/challenges/the-time-in-words/problem

  Consider:
    At , use o' clock. For , use past, and for use to
    if minutes are 15 -> quarter
    if minutes are 30 -> half
  """
  #Enter your code here. Read input from STDIN. Print output to STDOUT
  defp solution a, b do

    get_hours |> Enum.map(fn({w, n}) ->
      IO.puts "#{w} -> #{n}"
    end)
    5
  end

  defp get_hours do
    ["one", "two", "three", "four", "five", "six",
    "seven", "eight", "nine", "ten", "eleven", "twelve"]
    |> Enum.with_index(1)
  end

  def main(a, b) do
    solution(a, b) |> IO.puts
  end
end

# correct is: thirteen minutes to six
Solution.main("5", "47")

# correct is: three o' clock
Solution.main("3", "00")

# correct is: quarter past seven
Solution.main("7", "15")
