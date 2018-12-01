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
    {final_freq, _} =
      do_adjustments(starting_freq)

    final_freq
  end

  defp do_adjustments(starting_freq) do
    {final_freq, freqs} =
      File.stream!(path)
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {change, _} -> change end)
      |> adjust(starting_freq, %{})
  end

  def adjust([], current_freq, freqs), do: {current_freq, freqs}
  def adjust([head | tail], current_freq, freqs) do
    adjust(tail, current_freq + head, freqs)
  end

  defp path do
    case File.cwd() do
      {:ok, dir} -> Path.join([dir, "lib", @input])
      _ -> raise "Can't load the input file"
    end
  end
end
