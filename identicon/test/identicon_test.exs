defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "main returns all values not nil" do
    image = Identicon.main("Eduardo")
    assert image.hex != nil &&
        image.color != nil &&
        image.grid != nil
  end

  test "image contains a 3 color list in propery color" do
    image = Identicon.main("Eduardo")
    assert tuple_size(image.color) == 3
  end
end
