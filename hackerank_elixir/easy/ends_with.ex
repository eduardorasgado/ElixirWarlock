defmodule EndsWith do
  @moduledoc """
  Complete the solution so that it returns true if the first argument(string)
  passed in ends with the 2nd argument (also a string).
  """
  def solution(str, ending) do
    # Your code here
    String.ends_with?(
      String.Chars.to_string(str),
      String.Chars.to_string(ending))
  end
end

# true
IO.inspect EndsWith.solution('abc', 'bc')
# false
IO.inspect EndsWith.solution('abc', 'd')

IO.inspect EndsWith.solution("abc", "")
