"""
https://adventofcode.com/2018/day/2
"""

defmodule Day2 do
  alias InventoryManagement.{AdjacentBoxes, Checksum}

  def part1 do
    read_in
    |> checksum()
  end

  def part2 do
    read_in
    |> common_chars()
  end

  defp read_in do
    {:ok, dir} = File.cwd()

    Path.join([dir, "inputs", "input2.txt"])
    |> File.stream!()
    |> Enum.map(& &1)
  end

  def checksum(input) do
    Checksum.calculate(input)
  end

  def common_chars(input) do
    AdjacentBoxes.common_chars(input)
  end
end
