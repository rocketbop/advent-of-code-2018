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
      do_adjustments(starting_freq, read_in)

    final_freq
  end

  def first_duplicate(starting_freq) do
    adjustments = read_in
    {_, freqs} =
      do_adjustments(starting_freq, adjustments)
    
    build_list_until_duplicate_found([], Enum.reverse(freqs), adjustments)
  end

  def build_list_until_duplicate_found(new_list, [], adjustments) do
    [head | _] = new_list
    {_, freqs} =
      do_adjustments(head, adjustments)

    build_list_until_duplicate_found(new_list, Enum.reverse(freqs), adjustments)
  end
  def build_list_until_duplicate_found(new_list, [head | tail], adjustments) do
    cond do
      new_list |> Enum.any?(fn n -> n == head end) ->
        head
      true ->
        build_list_until_duplicate_found([head | new_list], tail, adjustments)
    end
  end

  def read_in do
    File.stream!(path)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {change, _} -> change end)
  end

  def do_adjustments(starting_freq, adjustments) do
    {final_freq, freqs} =
      adjustments
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
