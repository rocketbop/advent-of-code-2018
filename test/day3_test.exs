defmodule Day3Test do
  use ExUnit.Case

  @input ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

  @tag :focus
  test "finds the only claim with no shared inches" do
    assert Day3.part2(@input) == "#3"
  end

  test "converts a claim string into a tuple" do
    claim_string = "#1 @ 1,3: 4x2"
    expected = {"#1", [{1, 3}, {1, 4}, {2, 3}, {2, 4}, {3, 3}, {3, 4}, {4, 3}, {4, 4}]}

    assert Day3.prepare_claim(claim_string) == expected
  end

  test "it creates a list of coordinates from starting points with offsets" do
    assert Day3.co_ordinates(1, 3, 4, 2) == [
             {1, 3},
             {1, 4},
             {2, 3},
             {2, 4},
             {3, 3},
             {3, 4},
             {4, 3},
             {4, 4}
           ]
  end
end
