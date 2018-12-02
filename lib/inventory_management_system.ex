"""
https://adventofcode.com/2018/day/2
"""

defmodule InventoryManagementSystem do
  alias InventoryManagement.Checksum
  alias InventoryManagement.AdjacentBoxes

  def checksum(input) do
    Checksum.calculate(input)
  end

  def get_checksum_from_input do
    {:ok, dir} = File.cwd()

    Path.join([dir, "inputs", "input2.txt"])
    |> File.stream!()
    |> Enum.map(& &1)
    |> checksum()
  end

  def common_chars(input) do
    AdjacentBoxes.common_chars(input)
  end

  def get_common_chars_from_input do
    {:ok, dir} = File.cwd()

    Path.join([dir, "inputs", "input2.txt"])
    |> File.stream!()
    |> Enum.map(& &1)
    |> common_chars()
  end
end
