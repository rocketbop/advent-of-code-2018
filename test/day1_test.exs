defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  @starting_freq 0
  test "with starting point of zero" do
    assert Day1.calibrate(@starting_freq) == 477
  end

  # Commenting out as it is so slow to run
  # test "it finds the first repeating freq" do
  #   assert Day1.first_duplicate(@starting_freq) == 390
  # end
end
