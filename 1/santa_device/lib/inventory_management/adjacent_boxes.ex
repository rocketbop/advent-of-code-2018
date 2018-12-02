defmodule InventoryManagement.AdjacentBoxes do
  alias InventoryManagement.Hamming

  def common_chars(input) do
    input
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_charlist/1)
    |> adjacent_boxes
    |> common
    |> List.to_string
  end

  def adjacent_boxes(boxes) do
    Enum.reduce_while(boxes, 0, fn box1, acc ->
      if Enum.any?(boxes, fn box2 -> adjacent?(box1, box2) end) do
        {:halt, {box1, Enum.find(boxes, fn box2 -> adjacent?(box1, box2) end)}}
      else
        {:cont, 0}
      end
    end)
  end

  def adjacent?(box1, box2) do
    Hamming.distance(box1, box2) == {:ok, 1}
  end

  def common({box1, box2}) do
    box1
    |> Enum.with_index
    |> Enum.filter(fn {el, index} -> Enum.at(box2, index) == el end)
    |> Enum.map(fn {el, _} -> el end)
  end
end
