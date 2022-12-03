defmodule Day3 do
  def parse(data) when is_binary(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&to_charlist/1)
  end

  def part_one(input) do
    for rucksack <- input do
      {compartment_a, compartment_b} = Enum.split(rucksack, div(Enum.count(rucksack), 2))

      [common_item] =
        MapSet.new(compartment_a)
        |> MapSet.intersection(MapSet.new(compartment_b))
        |> MapSet.to_list()

      priority(common_item)
    end
    |> Enum.sum()
  end

  def part_two(input) do
    for [a, b, c] <- Enum.chunk_every(input, 3) do
      [common_item] =
        MapSet.new(a)
        |> MapSet.intersection(MapSet.new(b))
        |> MapSet.intersection(MapSet.new(c))
        |> MapSet.to_list()

      priority(common_item)
    end
    |> Enum.sum()
  end

  def priority(item) when item in ?a..?z, do: item - 96
  def priority(item) when item in ?A..?Z, do: item - 38
end
