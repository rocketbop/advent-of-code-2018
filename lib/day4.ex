defmodule Day4 do
  def strategy1(input) do
    input
    |> prepare_input()
    |> Enum.map(&parse_events/1)
    |> sort_by_date()
    # |> Enum.reduce([], fn event, acc ->
      
    # end)
  end

  defp parse_events(event) do
    {date_string, description} =
      event
      |> String.split("]")
      |> List.to_tuple()

    {parse_date_time(date_string), description}
  end

  defp parse_date_time(date_string) do
    date_string
    |> String.trim("[")
    |> String.replace(" ", "T")
    |> String.replace_suffix("", ":00Z")
    |> DateTime.from_iso8601()
    |> elem(1)
  end

  defp sort_by_date(events) do
    events
    |> Enum.sort_by(fn {date, _} ->
      {date.year, date.month, date.day, date.hour, date.minute}
    end)
  end

  defp prepare_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
  end
end
