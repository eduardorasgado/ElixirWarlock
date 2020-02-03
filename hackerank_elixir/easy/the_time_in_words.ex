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
  defp solution h_string, m_string do
    h = h_string |> String.to_integer
    m = m_string |> String.to_integer

    IO.inspect get_minutes()
    cond do
      m == 0 ->

        "#{Enum.at(get_hours(), h-1)} o' clock"
      m >= 1 && m <= 30 ->
        "shit"
      m > 30 ->
        "shit 2"
    end
  end

  defp get_elementals do
    [ "one", "two", "three", "four", "five", "six",
    "seven", "eight", "nine" ]
  end

  defp get_hours do
    # this creates a map of index words based on a list with indexes
    #["one", "two", "three", "four", "five", "six",
    #"seven", "eight", "nine", "ten", "eleven", "twelve"]
    #|> Enum.with_index(1)
    #|> Enum.map(fn({w, i})->
    #  {i, w}
    #end) |> Map.new
    get_elementals() ++ ["ten", "eleven", "twelve"]

  end

  defp get_minutes do
    get_hours() ++ String.split("thirteen fourteen quarter sixteen seventeen eighteen nineteen", " ")
    |> add_dec("twenty")
    |> add_dec("thirty")
    |> add_dec("fourty")
    |> add_dec("fifty")
    |> Enum.map(fn(element) ->
      cond do
        element == "thirty" -> "half"
        true -> element
      end
    end)
  end

  @doc """
  Inserting elements from a ten beginning and last nineth element
  Start by ten base and add next ten - one, ten - two, etc
  """
  defp add_dec(list, dec) do
    List.insert_at(list, -1, dec) ++ Enum.map(get_elementals(), fn(element) ->
      "#{dec} #{element}"
    end)
  end

  def main(h, m) do
    solution(h, m) |> IO.puts
  end
end

# correct is: thirteen minutes to six
Solution.main("5", "47")

# correct is: three o' clock
Solution.main("3", "00")

# correct is: quarter past seven
Solution.main("7", "15")

# correct is: half past five
Solution.main("5", "30")
