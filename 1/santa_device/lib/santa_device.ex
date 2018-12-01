defmodule SantaDevice do
  @moduledoc """
  Reads an accompanying input file and walks through
  each line adding or subtracting the numbers
  to recalibrate Santa's device
  """

  @doc """
  Calibrate
  ## Examples

  iex> SantaDevice.calibrate(10)
  487

  """
  @input "input.txt"
  def calibrate(starting_freq) do
    File.stream!(path)
    |> Enum.reduce(starting_freq, &adjust_freq/2)
  end

  defp path do
    case File.cwd() do
      {:ok, dir} -> Path.join([dir, "lib", @input])
      _ -> raise "Can't load the input file"
    end
  end

  defp adjust_freq(x, acc) do
    {change, _} = Integer.parse(x)
    acc + change
  end
end
