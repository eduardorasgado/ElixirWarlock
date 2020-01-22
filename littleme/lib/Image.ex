defmodule Littleme.Image do
  @moduledoc """
  This defmodule will represent Image struct to create Identicon

  hex: binary list
  color: 3 elements list
  grid: represents the actual 3 x 5 mirrored elements in a list
  """
  defstruct hex: nil,
            color: nil,
            grid: nil
end
