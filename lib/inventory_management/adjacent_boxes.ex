defmodule InventoryManagement.AdjacentBoxes do
  alias InventoryManagement.Hamming

  def common_chars(input) do
    input
    |> trimmed_charlists()
    |> adjacent_boxes()
    |> box_intersection()
  end

  defp trimmed_charlists(list) do
    list
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_charlist/1)
  end

  defp adjacent_boxes(boxes) do
    Enum.reduce_while(boxes, nil, fn box1, _ ->
      if box2 = Enum.find(boxes, &adjacent?(box1, &1)) do
        {:halt, {box1, box2}}
      else
        {:cont, nil}
      end
    end)
  end

  defp adjacent?(box1, box2) do
    Hamming.distance(box1, box2) == {:ok, 1}
  end

  defp box_intersection({box1, box2}) do
    box1
    |> Enum.with_index()
    |> Enum.filter(fn {el, index} -> Enum.at(box2, index) == el end)
    |> Enum.map(fn {el, _} -> el end)
    |> List.to_string()
  end
end
