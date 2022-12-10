defmodule Day10 do
  def parse(input) do
    {_cycle, _x, steps} =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce({0, 1, []}, fn
        "noop", {cycle, x, steps} ->
          {cycle + 1, x, steps}

        "addx " <> v, {cycle, x, steps} ->
          x = x + String.to_integer(v)
          cycle = cycle + 2
          {cycle, x, [{cycle, x} | steps]}
      end)

    [{0, 1} | Enum.reverse(steps)]
  end

  def part_one(input) do
    steps = parse(input)

    [20, 60, 100, 140, 180, 220]
    |> Enum.map(fn cycle -> cycle * x_value_at(steps, cycle - 1) end)
    |> Enum.sum()
  end

  def part_two(input) do
    steps = parse(input)

    Enum.map_join(0..6, "\n", fn y ->
      Enum.map_join(0..39, "", fn x ->
        if x_value_at(steps, y * 40 + x) in (x - 1)..(x + 1) do
          "#"
        else
          "."
        end
      end)
    end)
    |> IO.puts()
  end

  def x_value_at(steps, cycle) do
    Enum.zip(steps, tl(steps))
    |> Enum.find_value(fn {{start_cycle, x}, {end_cycle, _}} ->
      if cycle in start_cycle..(end_cycle - 1), do: x
    end)
  end
end
