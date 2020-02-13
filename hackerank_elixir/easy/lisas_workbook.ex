defmodule Solution do
  @moduledoc """
  Problem can be find here:
    https://www.hackerrank.com/challenges/lisa-workbook/problem
  """

  @doc """
  Hackerank solution
  """
  def main do

  end

  @doc """
  Dev environment main function.
  We will get:
    n, k
    p1 p2, p3, ... pth

    where n is the number of chapters
    k is the maximum number of problems per page
    pth is a n space separated integers  arr[i] where arr[i] denotes the number of problems in the ith chapter

    Mission: Count how many special problems do Lisa's book has.
  """
  def main_dev [n, k], chapter_list_with_problems do
    IO.puts solution(chapter_list_with_problems, k, n, 0, 0, 0)
  end

  defp solution(chapter_list_with_problems, max_probl_per_page, total_chap,
              chapter_i, current_final_page, total_special) do
    cond do
      chapter_i < total_chap ->
        # getting the total problems inside actual chapter
        chapter_problems = Enum.at(chapter_list_with_problems, chapter_i)
        # geting the actual chapter special problems and current final page
        [current_final_page, special_problems] = get_actual_page(chapter_problems, max_probl_per_page, current_final_page)
        solution(chapter_list_with_problems, max_probl_per_page, total_chap, chapter_i + 1, current_final_page, total_special + special_problems)
      true ->
        total_special
    end
  end

  defp get_actual_page chapter_problems, max_probl_per_page, current_final_page do
    total_pages_for_chap = ceil(chapter_problems / max_probl_per_page)
    # IO.puts "Total_page_for_chap is: #{total_pages_for_chap}, total before anything: #{current_final_page}"
    # creating a list as the diagram of the problem look like
    special_problems = 1..chapter_problems
    # getting problems by page
    |> Enum.chunk_every(max_probl_per_page)
    # every problem inside chapter index from 1
    |> Enum.with_index(1)
    |> Enum.map(fn({problems, index}) ->
      # index must be current actual page from lisa's workbook
      {problems, current_final_page + index}
    end)
    # finding the special problem where current page index should be == chapter problem index
    |> Enum.filter(fn({problems, index}) ->
      Enum.member?(problems, index)
    end)
    |> Enum.count

    [current_final_page + total_pages_for_chap, special_problems]
  end
end

#Solution.main()

# correct: 4
Solution.main_dev([5, 3], [4, 2, 6, 1, 10])
# correct: 8

