defmodule Day3 do
  def part1(input) do
    input
    |> Enum.map(&prepare_claim/1)

    # |> Enum.reduce(%{}, fn {claim_num, claimed_co_ordinates}, matrix ->

    #    end)
  end

  def prepare_claim(line) do
    [claim_num, _, starting_co_ordinates, distance] = String.split(line)

    [x_axis, y_axis] = String.split(distance, "x")
  end

  def co_ordinates(initial_x, initial_y, offset_x, offset_y) do
    for x <- initial_x..(initial_x + offset_x - 1),
        y <- initial_y..(initial_y + offset_y - 1) do
      {x, y}
    end
  end

  defp square_inches_with_multiple_claims(map) do
    Enum.filter(map, fn {key, value} -> value > 1 end)
  end
end
