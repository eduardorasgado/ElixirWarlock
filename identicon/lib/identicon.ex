defmodule Identicon do
  @moduledoc """
  Converts a string into an identicon

  This module uses md5 encoding to convert string into a binary
  We save the binary into a list
  we select the first 3 elements in the list to select the color for identicon
  The full list will be match to first 3 x 5 grids from identicon, we will toos las element in list
  Even number will be a color grid, odd number in binary list will be white grid
  To complete the 5x5 grid identicon we will mirror first 2 columns
  """

  @doc """
  Main function that will assemble the pipeline process
  """
  def main(input) do
    # even = color, #odd = white
    input
    |> hash_input
    |> pick_color
    |> grid_constructor
  end

  @doc """
  Converts a string input into a hash md5 code string
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  @doc """
  Function that takes first 3 elements from hex list and creates a 3 elements tuple
  that will act like rgb color
  This function returns a new Image struct with color assigned
  We can do pattern matching directly into parenthesis in def statement,
  """
  def pick_color(%Identicon.Image{ hex: hex_list } = input) do
    [ red, green, blue | _tail ] = hex_list
    # we use a pipe to assign elements from last struct to new one
    %Identicon
      .Image{
        input |
        color: {red,
                green,
                blue}
      }
  end

  @doc """
  Function that will convert a list of bin numbers into a list of color/white (1/0)
  """
  def grid_constructor(%Identicon.Image{ hex: hex_list} = input) do

    grid_list = hex_list
    |> Identicon.converts_to_string
    |> Enum.chunk_every(3,3, :discard)
    |> Identicon.mirror_row

    # creating a list of 3 elements list using hex list
    for list <- grid_list do
      Identicon.converts_to_number(list)
    end

    %Identicon.Image{ input | grid: grid_list }
  end

  @doc """
  converts every element in a list into a string element
  """
  def converts_to_string(list) do
    for element <- list do
      "#{element}"
    end
  end

  @doc """
  Creates a mirror list of lists, where first 2 elements will be repeated in every
  list but mirroring the 2 values before third and last value.
  """
  def mirror_row(input) do
    for row <- input do
      [ a, b, c ] = row
      #mirroring grid
      [ a, b, c, b, a]
    end
  end

  def converts_to_number(list) do
    for element <- list do
      {number, _rest} = Integer.parse(element)
      number
    end
  end

end
