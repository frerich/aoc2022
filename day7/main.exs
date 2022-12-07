defmodule Day7 do
  def parse(input) do
    {_, fs} =
      input
      |> String.split("\n", trim: true)
      |> Enum.reduce({[], %{}}, fn
        "$ ls", acc ->
          acc

        "$ cd /", {_stack, fs} ->
          {["/"], Map.put_new(fs, "/", [])}

        "$ cd ..", {[_ | stack], fs} ->
          {stack, fs}

        "$ cd " <> dir, {[cwd | _stack] = stack, fs} ->
          abs_path = "#{cwd}#{dir}/"
          {[abs_path | stack], Map.put_new(fs, abs_path, [])}

        "dir " <> dir, {[cwd | _] = stack, fs} ->
          abs_path = "#{cwd}#{dir}/"
          {stack, Map.update!(fs, cwd, &[{:dir, abs_path} | &1])}

        file_entry, {[cwd | _] = stack, fs} ->
          [size, file_name] = String.split(file_entry, " ")
          {stack, Map.update!(fs, cwd, &[{:file, file_name, String.to_integer(size)} | &1])}
      end)

    fs
  end

  def dir_size(fs, path) do
    fs[path]
    |> Enum.map(fn
      {:dir, path} -> dir_size(fs, path)
      {:file, _name, size} -> size
    end)
    |> Enum.sum()
  end

  def part_one(fs) do
    fs
    |> Enum.map(fn {dir, _nodes} -> dir_size(fs, dir) end)
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part_two(fs) do
    total_space = 70_000_000
    required_space = 30_000_000
    used_space = dir_size(fs, "/")

    fs
    |> Enum.map(fn {dir, _nodes} -> dir_size(fs, dir) end)
    |> Enum.filter(fn size -> used_space - size <= total_space - required_space end)
    |> Enum.min()
  end
end
