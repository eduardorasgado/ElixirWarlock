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

    %Littleme.Image{input | color: [red, green, blue]}
  end
end
