"""
https://adventofcode.com/2018/day/2
"""

defmodule Day2 do
  alias InventoryManagement.{AdjacentBoxes, Checksum}

  def part1(input \\ read_in) do
    Checksum.calculate(input)
  end

  def part2(input \\ read_in) do
    AdjacentBoxes.common_chars(input)
  end

  defp read_in do
    {:ok, dir} = File.cwd()

    Path.join([dir, "inputs", "day2.txt"])
    |> File.stream!()
    |> Enum.map(& &1)
  end
end
