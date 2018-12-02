defmodule Day2Test do
  use ExUnit.Case

  @input ~w[abcdef bababc abbcde abcccd aabcdd abcdee ababab]
  test "it calculates the correct checksum" do
    assert Day2.checksum(@input) == 12
  end

  test "it outputs the common chars between two adjacent boxes" do
    assert Day2.common_chars(@input) == "abcde"
  end
end
