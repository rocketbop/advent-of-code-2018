defmodule InventoryManagementSystem do
  def checksum(input) do
    maps =
      input
      |> Enum.map(&String.to_charlist/1)
      |> Enum.map(&charlist_count_map/1)

    num_of_occurences(maps, 2) * num_of_occurences(maps, 3)
  end

  defp num_of_occurences(maps, num) do
    Enum.count(maps, fn x -> Enum.any?(Map.values(x), &(&1 == num)) end)
  end

  defp charlist_count_map(charlist) do
    Enum.reduce(charlist, %{}, fn char, acc ->
      Map.update(acc, char, 1, &(&1 + 1))
    end)
  end
end
