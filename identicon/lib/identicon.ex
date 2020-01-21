defmodule Identicon do
  @doc """
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
end
