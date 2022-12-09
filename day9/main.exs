defmodule Day9 do
  def parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.flat_map(fn line ->
      case String.split(line, " ") do
        ["L", n] -> List.duplicate({-1, 0}, String.to_integer(n))
        ["R", n] -> List.duplicate({1, 0}, String.to_integer(n))
        ["U", n] -> List.duplicate({0, -1}, String.to_integer(n))
        ["D", n] -> List.duplicate({0, 1}, String.to_integer(n))
      end
    end)
  end

  def part_one(input) do
    input
    |> parse()
    |> Enum.scan([{0, 0}, {0, 0}], &drag_rope/2)
    |> Enum.uniq_by(fn [_head, tail] -> tail end)
    |> Enum.count()
  end

  def part_two(input) do
    input
    |> parse()
    |> Enum.scan(List.duplicate({0, 0}, 10), &drag_rope/2)
    |> Enum.uniq_by(fn rope -> Enum.at(rope, -1) end)
    |> Enum.count()
  end

  def drag_rope({dx, dy}, [{x, y}]) do
    [{x + dx, y + dy}]
  end

  def drag_rope({dx, dy}, [{x, y}, next | rest]) do
    head = {x + dx, y + dy}
    [head | drag_rope(drag_vector(head, next), [next | rest])]
  end

  def drag_vector({hx, hy}, {tx, ty}) do
    if abs(hx - tx) >= 2 || abs(hy - ty) >= 2 do
      {signum(hx - tx), signum(hy - ty)}
    else
      {0, 0}
    end
  end

  defp signum(0), do: 0
  defp signum(x) when x < 0, do: -1
  defp signum(x) when x > 0, do: 1
end
