defmodule Solution do
  @moduledoc """
  Solving the next problem:
    https://www.hackerrank.com/challenges/flatland-space-stations/problem
  """
  @doc """
  Hackerank main function to execute solution
  """
  def main do
    [n, m] = IO.gets("") |> String.strip |> String.split(" ") |> Enum.map(&String.to_integer/1)
    cities_with_sst = IO.gets("") |> String.strip |> String.split(" ") |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Dev main function to solve the problem in my computer
  We will receive:
  n m
  c1 c2, c3,..., cth

  where n is the number of cities
  m is the number of cities that contains a space station
  cth are the cities that have space stations

  It is important to consider that at the end we should get the max(d_c1, d_c2,...,d_cth)
  where d_cth is the max distance between city

  There are 3 possible cases for max distance:

    From left outermost city to first station (just lowest value of stations array);
    From right outermost city to last station (n - 1 - (max value of stations array));
    From city somewhere in the middle between 2 stations;

  All we have to do is to sort stations, find max distance between 2 stations,
  divide it by 2 to closest lowest integer and compare this distance with left distance and right distance.
  Max value will be result.

  GOAL:
  Determine the maximum distance from any city to it's nearest space station.
  """
  def main_dev([total_cities, num_cities_with_sst], cities_with_sst) do
    solution([total_cities, num_cities_with_sst], cities_with_sst)
  end

  defp solution([total_cities, num_cities_with_sst], cities_with_sst) do
    mid = div(total_cities, 2)

  end
end


#Solution.main()

# correct: 2
Solution.main_dev(
  [5, 2],
  # 0 and 4 cities have a space station
  [0, 4]
)

#correct: 0
Solution.main_dev(
  [6, 6],
  [0, 1, 2, 4, 3, 5]
)
