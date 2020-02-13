defmodule Challenge do
  def valid_braces(braces) do
    b_reference = [{"(", ")"}, {"{", "}"}, {"[", "]"}]
    m_p_m = braces |> String.graphemes
    |> braces_analizer(b_reference, 0, 0)
    rem(m_p_m, 2) == 0 && true || false
  end

  def braces_analizer(braces, b_reference, index, n_pattern_matched) do
    cond do
      index < Enum.count(braces) ->
      actual_brace_pair = Enum.filter(b_reference, fn({i, _l}) ->
        i == Enum.fetch!(braces, index)
      end)
      IO.inspect actual_brace_pair
      # actual_brace_pair != nil &&

      braces_analizer(braces, b_reference, index + 1, n_pattern_matched)
      true -> n_pattern_matched
    end
  end

  @doc """
   Function to find the next position of closing brace for actual brace pair beein analized
   within braces list at index position+1
  """
  def confirm_brace_closed(braces, actual_brace_pair, index) do

  end
end
IO.puts("----------")
IO.inspect Challenge.valid_braces("(){}[]")
IO.puts("----------")
IO.inspect Challenge.valid_braces("([{}])")
IO.puts("----------")
IO.inspect Challenge.valid_braces("(}")
IO.puts("----------")
IO.inspect Challenge.valid_braces("[(])")
IO.puts("----------")
IO.inspect Challenge.valid_braces("[({})](]")
