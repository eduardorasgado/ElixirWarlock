defmodule Identicon.Image do
  @moduledoc """
  Module to represent the image struct
  """

  defstruct hex: nil,
            color: nil,
            grid: nil,
            pixel_map: nil
end
