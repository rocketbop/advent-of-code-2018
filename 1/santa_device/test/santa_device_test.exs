defmodule SantaDeviceTest do
  use ExUnit.Case
  doctest SantaDevice

  @starting_freq 0
  test "with starting point of zero" do
    assert SantaDevice.calibrate(@starting_freq) == 477
  end

  test "it finds the first repeating freq" do
    assert SantaDevice.first_duplicate(@starting_freq) == -130301
  end
end
