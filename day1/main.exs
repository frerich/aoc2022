elves =
  for group <- String.split(File.read!("input.txt"), "\n\n") do
    group
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

part_one = elves |> Enum.map(&Enum.sum/1) |> Enum.max
part_two = elves |> Enum.map(&Enum.sum/1) |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum()

IO.inspect(part_one: part_one, part_two: part_two)
