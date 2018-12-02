"""
https://adventofcode.com/2018/day/2
"""

defmodule Day2 do
  alias InventoryManagement.{AdjacentBoxes, Checksum}

  def part1 do
    checksum(read_in)
  end

  def part2 do
    common_chars(read_in)
  end

  def checksum(input) do
    Checksum.calculate(input)
  end

  def common_chars(input) do
    AdjacentBoxes.common_chars(input)
  end

  defp read_in do
    {:ok, dir} = File.cwd()

    Path.join([dir, "inputs", "day2.txt"])
    |> File.stream!()
    |> Enum.map(& &1)
  end
end
