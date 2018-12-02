defmodule Day2Test do
  use ExUnit.Case

  @input ~w[abcdef bababc abbcde abcccd aabcdd abcdee ababab]
  test "it calculates the correct checksum" do
    assert Day2.part1(@input) == 12
  end

  test "it outputs the common chars between two adjacent boxes" do
    assert Day2.part2(@input) == "abcde"
  end
end
