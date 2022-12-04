defmodule Day4 do
  def parse(data) when is_binary(data) do
    for line <- String.split(data, "\n", trim: true) do
      [range_a, range_b] = String.split(line, ",")
      {parse_range(range_a), parse_range(range_b)}
    end
  end

  def part_one(input) do
    Enum.count(input, fn {range_a, range_b} ->
      (range_a.first >= range_b.first && range_a.last <= range_b.last) ||
        (range_b.first >= range_a.first && range_b.last <= range_a.last)
    end)
  end

  def part_two(input) do
    Enum.count(input, fn {range_a, range_b} -> not Range.disjoint?(range_a, range_b) end)
  end

  defp parse_range(range) do
    [p, q] = String.split(range, "-")
    String.to_integer(p)..String.to_integer(q)
  end
end
