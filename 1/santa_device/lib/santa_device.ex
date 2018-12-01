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

  def first_duplicate(starting_freq) do
    {_, freqs} =
      do_adjustments(starting_freq)
    
    build_list_until_duplicate_found([], freqs)
  end

  def build_list_until_duplicate_found(new_list, []) do
    [head | _] = new_list
    {_, freqs} =
      do_adjustments(head)

    build_list_until_duplicate_found(new_list, freqs)
  end
  def build_list_until_duplicate_found(new_list, [head | tail]) do
    cond do
      new_list |> Enum.any?(fn n -> n == head end) ->
        head
      true ->
        build_list_until_duplicate_found([head | new_list], tail)
    end
  end

  def do_adjustments(starting_freq) do
    {final_freq, freqs} =
      File.stream!(path)
      |> Enum.map(&Integer.parse/1)
      |> Enum.map(fn {change, _} -> change end)
      |> adjust(starting_freq, [])
  end

  def adjust([], current_freq, freqs), do: {current_freq, freqs}
  def adjust([head | tail], current_freq, freqs) do
    new_freq = current_freq + head
    adjust(tail, new_freq, [new_freq | freqs])
  end

  defp path do
    case File.cwd() do
      {:ok, dir} -> Path.join([dir, "lib", @input])
      _ -> raise "Can't load the input file"
    end
  end
end
