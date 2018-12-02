defmodule InventoryManagementSystemTest do
  use ExUnit.Case

  test "it calculates the correct checksum" do
    input = ~w[abcdef bababc abbcde abcccd aabcdd abcdee ababab]
    assert InventoryManagementSystem.checksum(input) == 12
  end
end
