defmodule Day3 do
  def part1(input) do
    input
    |> get_matrix
    |> Map.values()
    |> Enum.count(fn list -> Enum.count(list) > 1 end)
  end

  def part2(input) do
    input
    |> get_matrix()
    |> guesses_and_matrix()
    |> Enum.find(fn {guess, matrix} -> guess_without_overlaps?(guess, matrix) end)
    |> elem(0)
  end

  def guesses_and_matrix(matrix) do
    matrix
    |> Map.values()
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.map(&{&1, matrix})
  end

  def guess_without_overlaps?(guess, matrix) do
    matrix
    |> Enum.filter(fn {k, v} -> Enum.member?(v, guess) end)
    |> Enum.all?(fn {k, v} -> Enum.count(v) == 1 end)
  end



  """
  Return
    %{
      {1, 3} => ["#1"],
      {1, 4} => ["#1"],
      {1, 5} => ["#1"],
    }
  """

  defp get_matrix(input) do
    input
    |> Enum.map(&prepare_claim/1)
    |> Enum.reduce(%{}, fn {claim_num, claimed_co_ordinates_list}, matrix ->
      Enum.reduce(claimed_co_ordinates_list, matrix, fn co_ordinates, acc ->
        acc = Map.update(acc, co_ordinates, [claim_num], fn val -> [claim_num | val] end)
      end)
    end)
  end

  def prepare_claim(line) do
    [claim_num, _, starting_co_ordinates, distance] = String.split(line, " ", trim: true)

    [{initial_x, _}, {initial_y, _}] =
      starting_co_ordinates
      |> String.replace(~r{:}, "")
      |> String.split(",")
      |> Enum.map(&Integer.parse/1)

    [{x_axis, _}, {y_axis, _}] =
      distance
      |> String.split("x")
      |> Enum.map(&Integer.parse/1)

    {claim_num, co_ordinates(initial_x, initial_y, x_axis, y_axis)}
  end

  def co_ordinates(initial_x, initial_y, offset_x, offset_y) do
    for x <- initial_x..(initial_x + offset_x - 1),
        y <- initial_y..(initial_y + offset_y - 1) do
      {x, y}
    end
  end
end
