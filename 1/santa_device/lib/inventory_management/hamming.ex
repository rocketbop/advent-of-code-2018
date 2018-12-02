defmodule InventoryManagement.Hamming do
  def distance(strand1, strand2) do
    distance(strand1, strand2, 0)
  end

  defp distance([], [], difference), do: {:ok, difference}

  defp distance([h | t1], [h | t2], difference) do
    distance(t1, t2, difference)
  end

  defp distance([_h1 | t1], [_h2 | t2], difference) do
    distance(t1, t2, difference + 1)
  end
end
