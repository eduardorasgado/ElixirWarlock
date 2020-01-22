defmodule LittlemeTest do
  use ExUnit.Case
  doctest Littleme

  test "greets the world" do
    assert Littleme.hello() == :world
  end
end
