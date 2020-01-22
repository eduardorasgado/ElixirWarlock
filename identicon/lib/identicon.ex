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
    |> filter_odd_squares
    |> build_pixel_map
  end

  @doc """
  Converts a string input into a hash md5 code string
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
  Function that takes first 3 elements from hex list and creates a 3 elements tuple
  that will act like rgb color
  This function returns a new Image struct with color assigned
  We can do pattern matching directly into parenthesis in def statement,
  """
  def pick_color(%Identicon.Image{hex: hex_list} = input) do
    [red, green, blue | _tail] = hex_list
    # we use a pipe to assign elements from last struct to new one
    %Identicon.Image{
      input
      | color: {red, green, blue}
    }
  end

  @doc """
  Function that will convert a list of bin numbers into a list of color/white (1/0)
  """
  def grid_constructor(%Identicon.Image{hex: hex_list} = input) do
    grid_list =
      hex_list
      |> Identicon.converts_to_string()
      |> Enum.chunk_every(3, 3, :discard)
      # passing a reference to a function, we pass a /1 to indicates what mirror_row version of function
      # it is about, if we would have more than one mirror function it is useful
      |> Enum.map(&Identicon.mirror_row/1)
      # creating just one list and not nested one
      |> List.flatten
      |> Enum.map(&Identicon.converts_to_number/1)
      |> Enum.with_index

    %Identicon.Image{input | grid: grid_list}
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
  Creates a mirror list, where first 2 elements will be repeated in every
  list but mirroring the 2 values before third and last value.
  """
  def mirror_row(row) do
    [first, second | _tail] = row
    # mirroring grid, ++ is the way to list addition
    row ++ [second, first]
  end

  @doc """
  Converts a string list into integer list
  """
  def converts_to_number(string_num) do
    {number, _rest} = Integer.parse(string_num)
    number
  end

  @doc """
  This function will convert every even in color and every odd in
  white
  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = input) do

    # we are performing a function for every list in grid
    grid = Enum.filter grid, fn({value, _index}) ->
        rem(value, 2) == 0
    end

    %Identicon.Image{input | grid: grid}
  end

  @doc """
  This function will create a the pixel map
  every element in the list will represent colored grid in
  pixel map

  300 x 300 identicon,
  5 x 5 grid
  50 x 50 pxls individual grid
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = input) do
    pixel_map = Enum.map grid, fn({_value, index}) ->
      # top left
      horizontal = div(index, 5) * 50
      vertical = rem(index, 5) * 50
      #point
      top_left = { horizontal, vertical }
      bottom_right = {horizontal + 50, vertical + 50}

      # pixel pairs
      {top_left, bottom_right}
    end

    %Identicon.Image{input | pixel_map: pixel_map}
  end
end
