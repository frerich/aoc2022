defmodule Day2 do
  @loss 0
  @draw 3
  @win 6

  @rock_score 1
  @paper_score 2
  @scissors_score 3

  def part1(lines) do
    lines
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

  def part2(lines) do
    lines
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

ExUnit.start()

defmodule Tests do
  use ExUnit.Case

  describe "part1" do
    test "example" do
      assert Day2.part1(["A Y", "B X", "C Z"]) == 15
    end

    test "input" do
      input = File.read!("input.txt") |> String.split("\n", trim: true)
      assert Day2.part1(input) == 11767
    end
  end

  describe "part2" do
    test "example" do
      assert Day2.part2(["A Y", "B X", "C Z"]) == 12
    end

    test "input" do
      input = File.read!("input.txt") |> String.split("\n", trim: true)
      assert Day2.part2(input) == 13886
    end
  end
end
