defmodule Day2 do
  @loss 0
  @draw 3
  @win 6

  @rock_score 1
  @paper_score 2
  @scissors_score 3

  def part1(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      case String.split(line) do
        ["A", "X"] -> @draw + @rock_score
        ["A", "Y"] -> @win + @paper_score
        ["A", "Z"] -> @loss + @scissors_score
        ["B", "X"] -> @loss + @rock_score
        ["B", "Y"] -> @draw + @paper_score
        ["B", "Z"] -> @win + @scissors_score
        ["C", "X"] -> @win + @rock_score
        ["C", "Y"] -> @loss + @paper_score
        ["C", "Z"] -> @draw + @scissors_score
      end
    end)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn line ->
      case String.split(line) do
        ["A", "X"] -> @loss + @scissors_score
        ["A", "Y"] -> @draw + @rock_score
        ["A", "Z"] -> @win + @paper_score
        ["B", "X"] -> @loss + @rock_score
        ["B", "Y"] -> @draw + @paper_score
        ["B", "Z"] -> @win + @scissors_score
        ["C", "X"] -> @loss + @paper_score
        ["C", "Y"] -> @draw + @scissors_score
        ["C", "Z"] -> @win + @rock_score
      end
    end)
    |> Enum.sum()
  end
end

input = File.read!("input.txt") |> String.trim()
IO.inspect(part_1: Day2.part1(input))
IO.inspect(part_2: Day2.part2(input))

