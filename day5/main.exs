defmodule Day5 do
  def parse(input) do
    [stacks, steps] = String.split(input, "\n\n")

    crate_names =
      for line <- Enum.drop(String.split(stacks, "\n"), -1) do
        chars = to_charlist(line)
        Enum.map(1..String.length(line)//4, &Enum.at(chars, &1))
      end

    stacks =
      crate_names
      |> transpose()
      |> Enum.with_index(1)
      |> Map.new(fn {stack, index} ->
        {index, Enum.drop_while(stack, &(&1 == ?\s))}
      end)

    steps =
      for step <- String.split(steps, "\n", trim: true) do
        ["move", n, "from", src, "to", dst] = String.split(step)
        {String.to_integer(n), String.to_integer(src), String.to_integer(dst)}
      end

    {stacks, steps}
  end

  def part_one({stacks, steps}) do
    stacks |> execute(steps, &Enum.reverse/1) |> top_crates()
  end

  def part_two({stacks, steps}) do
    stacks |> execute(steps) |> top_crates()
  end

  def execute(stacks, steps, drop_fun \\ & &1) do
    Enum.reduce(steps, stacks, fn {n, src, dst}, stacks ->
      {crates, rest} = Enum.split(stacks[src], n)

      stacks
      |> Map.put(src, rest)
      |> Map.update!(dst, &(drop_fun.(crates) ++ &1))
    end)
  end

  def top_crates(stacks) do
    stacks
    |> Enum.sort_by(fn {idx, _v} -> idx end)
    |> Enum.map(fn {_idx, [crate | _]} -> crate end)
  end

  defp transpose(list), do: Enum.zip_with(list, & &1)
end
