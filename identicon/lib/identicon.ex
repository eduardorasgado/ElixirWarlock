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
  Main function that will assemble the pipe process
  """
  def main(input) do
    input 
    |> hash_input

    # even = color, #odd = white
  end

  @doc """
  Converts a string input into a hash md5 code string 
  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input) 
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
