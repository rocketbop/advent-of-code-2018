defmodule SantaDeviceTest do
  use ExUnit.Case
  doctest SantaDevice

  @starting_freq 0
  test "with starting point of zero" do
    assert SantaDevice.calibrate(@starting_freq) == 477
  end
end
