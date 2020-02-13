defmodule Spin do
  @moduledoc """
  Write a function that takes in a string of one or more words, and returns the same string,
  but with all five or more letter words reversed (Just like the name of this Kata).
  Strings passed in will consist of only letters and spaces. Spaces will be included
  only when more than one word is present.

  Examples: spinWords( "Hey fellow warriors" ) => returns "Hey wollef sroirraw"
  spinWords( "This is a test") => returns "This is a test"
  spinWords( "This is another test" )=> returns "This is rehtona test"

  """
  def spin_words(message) do
    #   TODO: Have fun :)
    message
    |> String.split(" ")
    |> Enum.map_join(" ", &(String.length(&1) > 5 && String.reverse(&1) || &1))
  end
end

# returns "Hey wollef sroirraw"
IO.puts Spin.spin_words( "Hey fellow warriors" )
# returns "This is a test"
IO.puts Spin.spin_words( "This is a test" )
# returns "This is rehtona test"
IO.puts Spin.spin_words( "This is another test")
