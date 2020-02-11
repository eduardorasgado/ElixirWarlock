defmodule Solution do
  def main do
    IO.gets("") |> String.trim |> String.to_integer |> solution()

  end

  defp solution n do
    cond do
    n > 0 ->
      IO.puts "Hello World"
      solution(n-1)
    true -> nil
    end
  end
end

Solution.main()
