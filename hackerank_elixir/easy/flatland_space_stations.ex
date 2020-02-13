defmodule Solution do
  @moduledoc """
  Solving the next problem:
    https://www.hackerrank.com/challenges/flatland-space-stations/problem
  """
  @doc """
  Hackerank main function to execute solution
  """
  def main do
    [n, m] = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)
    cities_with_sst = IO.gets("") |> String.trim |> String.split(" ") |> Enum.map(&String.to_integer/1)
    IO.puts solution([n, m], cities_with_sst)
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
    IO.puts solution([total_cities, num_cities_with_sst], cities_with_sst)
  end

  defp solution([total_cities, _num_cities_with_sst], cities_with_sst) do
    get_closest_stations(total_cities, cities_with_sst)

  end

  defp get_closest_stations(total_cities, cities_with_sst) do
    # assembling a list structure like this:
    # {city, nearest station, if it has an station, all the cities with space stations}
    cities = 0..total_cities-1
    |> Enum.map(fn(city) ->
      {city, 0, Enum.member?(cities_with_sst, city), cities_with_sst}
    end)
    |> get_nearest_station

    [_c, max_distance | _tail] =
      cities
      |> Enum.max_by(fn({_, cls_sst_distance, _, _}) ->
        cls_sst_distance
      end)
      |> Tuple.to_list

      max_distance
  end

  defp get_nearest_station(cities) do
    # we are iterating over all the cities and if they have space stations
    # they will be marked as cero the nearest space station distance
    # but if they does not have SS then we will iterate over all cities with SS
    # and will get the nearest SS for the given city case
    cities |>
    Enum.map(fn({cty, _cls_sst, w_sst, cities_with_sst}) ->
      cond do
        w_sst == true ->
          {cty, 0, w_sst, cities_with_sst}
        true ->
          # here we should get the nearest station
          # expanding cities_with_sst to {city, difference between c_W_sst and currect city analized}
          {_c_w_sst, nearest_distance} = Enum.map(cities_with_sst, fn(c) ->
            {c, abs(cty - c)}
          end)
          |> Enum.min_by(fn({_c, diff})->
            diff
          end)
          {cty, nearest_distance, w_sst, cities_with_sst}
      end
    end)
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
