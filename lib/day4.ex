defmodule Day4 do
  def strategy1(input) do
    input
    |> prepare_input()
    |> Enum.map(&parse_events/1)
    |> sort_by_date()
    |> group_guards_and_events([], nil)
    |> Enum.map(&calculate_sleeping_time/1)
    |> Enum.max_by(fn {num, id} -> num end)
    |> IO.inspect
  end

  def calculate_sleeping_time({_, date_descs}) do
    calculate_sleeping_time(date_descs, 0, nil)
  end

  def calculate_sleeping_time([head | tail], time_sleeping, guard_num) do
    case head do
      {_, :awake, _, guard_num} ->
        calculate_sleeping_time(tail, time_sleeping, guard_num)
      {date_time, :asleep, _, guard_num} ->
        calculate_sleeping_time(tail, time_sleeping, date_time, guard_num)
    end
  end

  def calculate_sleeping_time([head | tail], time_sleeping, time_fell_asleep, guard_num) do
    case head do
      {time_woke, :awake, _, guard_num} ->
        time_just_slept =
          time_woke
          |> DateTime.diff(time_fell_asleep, :second)
          |> div(60)
        calculate_sleeping_time(tail, time_sleeping + time_just_slept, guard_num)
      {_, :asleep, _, _} ->
        calculate_sleeping_time(tail, time_sleeping, time_fell_asleep, guard_num)
    end
  end

  def calculate_sleeping_time([], time_sleeping, guard_num) do
    {time_sleeping, guard_num}
  end

  def group_guards_and_events([{date, desc} | tail], guard_events, current_guard_id) do
    cond do
      String.contains?(desc, "#") ->
        id = guard_id({nil, desc})
        group_guards_and_events(tail, [{date, :awake, desc, id} | guard_events], id)

      String.contains?(desc, "asleep") ->
        group_guards_and_events(
          tail,
          [{date, :asleep, desc, current_guard_id} | guard_events],
          current_guard_id
        )

      true ->
        group_guards_and_events(
          tail,
          [{date, :awake, desc, current_guard_id} | guard_events],
          current_guard_id
        )
    end
  end

  def group_guards_and_events([], guard_events, current_guard_id) do
    guard_events
    |> Enum.reverse()
    |> Enum.group_by(fn {_, _, _, id} -> id end)
  end

  def guard_id({_, desc}) do
    cond do
      String.contains?(desc, "Guard") ->
        desc
        |> String.split()
        |> Enum.at(1)
        |> String.trim("#")

      true ->
        nil
    end
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
