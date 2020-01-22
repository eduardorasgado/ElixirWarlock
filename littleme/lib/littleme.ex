defmodule Littleme do
  @moduledoc """
  Little me is a "try to clone by my self" the identicon project.

  This module creates a identicon image based on a string
  """

  @doc """
  Main function of the module. This module represents and initiate the identicon creation pipeline
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> grid_generator
    |> filter_odd_squares
  end

  @doc """
  This function hash a string using md5 algorithm and returns a list of binary data
  """
  def hash_input(input) do
    binary = :crypto.hash(:md5, input)
    hex = :erlang.binary_to_list(binary)

    %Littleme.Image{hex: hex}
  end

  @doc """
  This function will take first three elements from a list and will return a Image struct
  """
  def pick_color(input) do
    [red, green, blue | _tail] = input.hex

    %Littleme.Image{input | color: {red, green, blue}}
  end

  @doc """
  This function will create a list of 3 x 5 image grid but mirrored and inside a list
  """
  def grid_generator(%Littleme.Image{hex: hex} = input) do
    grid =
    Enum.chunk_every(hex, 3, 3, :discard)
    |> Enum.map(&Littleme.mirror_row/1)
    |> List.flatten
    |> Enum.with_index

    %Littleme.Image{input | grid: grid}
  end

  @doc """
  Takes a 1 x 3 list and mirrors first and second element inside and returns it
  """
  def mirror_row(row) do
    [first, second, _tail] = row
    row ++ [second, first]
  end

  @doc """
  This function filters a list of tuples, returns Image struct with a grid of just even tuples
  """
  def filter_odd_squares(%Littleme.Image{grid: grid} = input) do
    even_grid = Enum.filter grid, fn({value, _index}) ->
      rem(value, 2) == 0
    end

    %Littleme.Image{input | grid: even_grid}
  end
end
