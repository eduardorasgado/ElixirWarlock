defmodule Solution do
  @moduledoc """
  Implementing the solution for the next problem:
    https://www.hackerrank.com/challenges/service-lane/problem
  """

  @doc """
  function to receive official main to upload to hackerank
  """
  def main do
    [n, t] = get_stdin()
    width_list = get_stdin()

    #IO.puts "#{n} #{t}"

    1..t |> Enum.each(fn(_e) ->
      # for every given test case
      [i, j] = get_stdin()
      # IMPLEMENTATION SHOULD GO HERE
      IO.puts "#{i} #{j}"
    end)
  end

  @doc """
  algorithm dev environment for dev only
  We will receive
  n, t
  [width list]
  i1, j1
  i2, j2,
  ...
  where n is number of elements inside the w list
  where t is the number of test
  where i-th is the start index
  where j-th is the end index of the segment been considered
  """
  def main_dev [n, t], width_list, test_list do
    # for every test case
    cond do
      n < 2 && n > 100000 -> nil
      t < 1 && t > 1000 -> nil
      !testing_with_k(width_list, n-1, true) -> nil
      true ->
        Enum.each(test_list, fn([i, j]) ->
          cond do
            0 <= i && i < j &&  j < n && 2<= (j - i + 1)
                  && (j - i + 1) <= Enum.min(n..1000) ->
              IO.puts solution(n, width_list, i, j)
            true -> nil
          end
        end)
    end
  end

  defp solution n, width_list, i_start, j_end do
    # getting the max width for every test
    Enum.with_index(width_list)
    |> Enum.filter(fn({_width, index}) ->
      index >= i_start && index <= j_end
    end)
    |> Enum.map(fn({w, _i}) ->
      w
    end)
    |> Enum.min
  end

  defp get_stdin do
    IO.gets("")
      |> String.strip
      |> String.split(" ")
      |> Enum.map(fn(e) ->
        String.to_integer(e)
      end)
  end

  defp testing_with_k(width_list, n, value) do
    # this function will analyze every element within the width list
    # and if some one does not fullfil de range then it will return a
    # false as value to main func call
    cond do
      value == false -> false
      n >= 0 ->
        element = Enum.at(width_list, n)
        #IO.puts "Evals to #{element}"
        cond do
          (element <= 3) && (element >= 1) ->
            testing_with_k(width_list, n-1, true)
          true ->
            testing_with_k(width_list, n-1, false)
        end
      true -> value
    end
  end
end

#Solution.main()

# correct: 1 2 3 2 1
Solution.main_dev [8, 5], [2, 3, 1, 2, 3, 2, 3, 3],
  [
    [0, 3],
    [4, 6],
    [6, 7],
    [3, 5],
    [0, 7]
  ]

IO.puts "-----------------"

Solution.main_dev [5, 5], [1, 2, 2, 2, 1],
[
  [2, 3],
  [1, 4],
  [2, 4],
  [2, 4],
  [2, 3]
]
