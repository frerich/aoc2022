defmodule Day6 do
  def part_one(input) do
    chunks = Enum.chunk_every(to_charlist(input), 4, 1)
    Enum.find_index(chunks, & Enum.uniq(&1) == &1) + 4
  end

  def part_two(input) do
    chunks = Enum.chunk_every(to_charlist(input), 14, 1)
    Enum.find_index(chunks, & Enum.uniq(&1) == &1) + 14
  end
end
