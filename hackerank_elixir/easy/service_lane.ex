defmodule Solution do
  @moduledoc """
  Implementing the solution for the next problem:
    https://www.hackerrank.com/challenges/service-lane/problem
  """

  @doc """
  function to receive official main to upload to hackerank
  we will receive:

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
  def main do
    [n, t] = get_stdin()
    width_list = get_stdin()

    #IO.puts "#{n} #{t}"

    1..t |> Enum.each(fn(_e) ->
      # for every given test case
      [i, j] = get_stdin()
      IO.puts "#{i} #{j}"
    end)
  end

  defp get_stdin do
    IO.gets("")
      |> String.strip
      |> String.split(" ")
      |> Enum.map(fn(e) ->
        String.to_integer(e)
      end)
  end
end

Solution.main()
