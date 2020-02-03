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
    m = m_string
    |> String.to_integer
    h = h_string |> String.to_integer

    minute = searching_element_in_time(m, get_minutes())
    hour = searching_element_in_time(h, get_hours())
    cond do
      m == 0 ->
        "#{hour} o' clock"
      m >= 1 && m <= 30 ->
        # minute when 1 and minutes everything but quarter, quarter should have no company word
        min_literal = if m != 1 and m != 15 and m != 30,
                      do: " minutes ", else:
                        if m == 1, do: " minute ", else: " "
        "#{minute}#{min_literal}past #{hour}"
      m > 30 ->
        minute = searching_element_in_time(60-m, get_minutes())
        hour = searching_element_in_time(rem(h+1, 12), get_hours())
        # if quarter then string should not include minutes word
        min_literal = if m != 45, do: " minutes ", else: " "
        "#{minute}#{min_literal}to #{hour}"
    end
  end

  defp searching_element_in_time e, list do
    Enum.at(list, e - 1)
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
        element == "fourty five" -> "quarter"
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

# correct is: one minute to six
Solution.main("5", "01")

# correct is: five minutes past seven
Solution.main("7", "05")

# correct is: three o' clock
Solution.main("3", "00")

# correct is: half past three
Solution.main("3", "30")

# correct is: quarter past seven
Solution.main("7", "15")

# correct is: half past five
Solution.main("5", "30")

# correct is: thirteen minutes to six
Solution.main("5", "47")

# correct is: thirteen minutes to one
Solution.main("12", "47")

# correct is: quarter to six
Solution.main("5", "45")
