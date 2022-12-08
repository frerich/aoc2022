defmodule Day8 do
  def parse(input) when is_binary(input) do
    for {line, y} <- Enum.with_index(String.split(input, "\n")),
        {char, x} <- Enum.with_index(to_charlist(line)),
        into: %{} do
      {{x, y}, char - ?0}
    end
  end

  def part_one(input) do
    grid = parse(input)

    Enum.count(grid, fn
      {pos, height} ->
        Enum.all?(line_of_sight(grid, pos, {0, -1}, 10), &(grid[&1] < height)) ||
          Enum.all?(line_of_sight(grid, pos, {0, 1}, 10), &(grid[&1] < height)) ||
          Enum.all?(line_of_sight(grid, pos, {-1, 0}, 10), &(grid[&1] < height)) ||
          Enum.all?(line_of_sight(grid, pos, {1, 0}, 10), &(grid[&1] < height))
    end)
  end

  def part_two(input) do
    grid = parse(input)

    grid
    |> Enum.map(fn {pos, height} ->
      Enum.count(line_of_sight(grid, pos, {0, -1}, height)) *
        Enum.count(line_of_sight(grid, pos, {0, 1}, height)) *
        Enum.count(line_of_sight(grid, pos, {-1, 0}, height)) *
        Enum.count(line_of_sight(grid, pos, {1, 0}, height))
    end)
    |> Enum.max()
  end

  def line_of_sight(grid, {x, y}, {dx, dy}, max_height) do
    next = {x + dx, y + dy}

    case grid[next] do
      nil ->
        []

      height when height >= max_height ->
        [next]

      _ ->
        [next | line_of_sight(grid, next, {dx, dy}, max_height)]
    end
  end
end
