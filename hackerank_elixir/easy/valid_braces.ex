defmodule Challenge do
  def valid_braces(braces) do
    b_reference = [{"(", ")"}, {"{", "}"}, {"[", "]"}]
    n_p_m = braces |> String.graphemes
    |> braces_analizer(b_reference, 0, 0)
    IO.puts "n_p_M: #{n_p_m  *2}, #{Enum.count(String.graphemes(braces))} "
    n_p_m * 2 == Enum.count(String.graphemes(braces)) && true || false
  end

  def braces_analizer(braces, b_reference, index, n_pattern_matched) do
    cond do
      index < Enum.count(braces) ->
      actual_brace_pair = Enum.filter(b_reference, fn({i, _l}) ->
        i == Enum.fetch!(braces, index)
      end)

      # adding indexes before recurtion
      #braces_w_i = braces
      #  |> Enum.with_index()

      #IO.inspect actual_brace_pair

      cond do
        Enum.empty?(actual_brace_pair) == false ->
          IO.puts "index + 1: #{index + 1}"
          index_right_side = confirm_brace_closed(braces, actual_brace_pair, index + 1)
          IO.inspect "diff: #{index_right_side - index - 1}"
          inc =
          incremets = (rem(index_right_side - index - 1, 2) == 0 && index_right_side != Enum.count(braces))
            && n_pattern_matched + 1 || n_pattern_matched
          braces_analizer(braces, b_reference, index + 1, incremets)
        true ->
          braces_analizer(braces, b_reference, index + 1, n_pattern_matched)
      end

      true -> n_pattern_matched
    end
  end

  @doc """
   Function to find the next position of closing brace for actual brace pair beein analized
   within braces list at index position+1
  """
  def confirm_brace_closed(braces, actual_brace_pair, index) do

    [{_i, l}] = actual_brace_pair

    cond do
      Enum.at(braces, index) == l || index >= Enum.count(braces)->
        # IO.inspect index
        index
       true -> confirm_brace_closed(braces, actual_brace_pair, index + 1)
    end
    # new index come here or nil, cuz there is a chance to get no no closing c brace
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
IO.puts("----------")
IO.inspect Challenge.valid_braces(")(}{][")
IO.puts("----------")
IO.inspect Challenge.valid_braces("(({{[[]]}}))")

