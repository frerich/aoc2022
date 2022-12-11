defmodule Day11 do
  def parse(input) when is_binary(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn block ->
      [
        <<"Monkey ", monkey_id::binary-size(1), ":">>,
        <<"  Starting items: ", item_spec::binary>>,
        <<"  Operation: new = old ", operator::binary-size(1), " ", operand::binary>>,
        <<"  Test: divisible by ", divisor::binary>>,
        <<"    If true: throw to monkey ", true_target_id::binary>>,
        <<"    If false: throw to monkey ", false_target_id::binary>>
      ] = String.split(block, "\n", trim: true)

      items = item_spec |> String.split(", ") |> Enum.map(&String.to_integer/1)

      worry_fn =
        case {operator, operand} do
          {"+", "old"} -> &(&1 + &1)
          {"+", n} -> &(&1 + String.to_integer(n))
          {"*", "old"} -> &(&1 * &1)
          {"*", n} -> &(&1 * String.to_integer(n))
        end

      {String.to_integer(monkey_id),
       %{
         items: items,
         worry_fn: worry_fn,
         divisor: String.to_integer(divisor),
         true_target_id: String.to_integer(true_target_id),
         false_target_id: String.to_integer(false_target_id)
       }}
    end)
    |> Map.new()
  end

  def part_one(input) do
    input
    |> parse()
    |> monkey_business(20, fn worry_level -> trunc(worry_level / 3) end)
  end

  def part_two(input) do
    monkeys = parse(input)

    product = Enum.reduce(monkeys, 1, fn {_id, monkey}, product -> product * monkey.divisor end)

    input
    |> parse()
    |> monkey_business(10_000, fn worry_level -> rem(worry_level, product) end)
  end

  def monkey_business(monkeys, num_rounds, worry_limiting_fn) do
    {min_id, max_id} = Enum.min_max(Map.keys(monkeys))

    {_monkeys, num_items_inspected} =
      Stream.cycle(min_id..max_id)
      |> Enum.take((max_id - min_id + 1) * num_rounds)
      |> Enum.reduce({monkeys, %{}}, fn monkey_id, {monkeys, num_items_inspected} ->
        num_items = Enum.count(monkeys[monkey_id].items)

        num_items_inspected =
          Map.update(num_items_inspected, monkey_id, num_items, &(&1 + num_items))

        monkeys = turn(monkeys, monkey_id, worry_limiting_fn)

        {monkeys, num_items_inspected}
      end)

    [first, second | _] = num_items_inspected |> Map.values() |> Enum.sort(:desc)
    first * second
  end

  def turn(monkeys, monkey_id, worry_limiting_fn) do
    monkey = monkeys[monkey_id]

    monkey.items
    |> Enum.reduce(monkeys, fn worry_level, monkeys ->
      worry_level = worry_limiting_fn.(monkey.worry_fn.(worry_level))

      target_monkey_id =
        if rem(worry_level, monkey.divisor) == 0 do
          monkey.true_target_id
        else
          monkey.false_target_id
        end

      update_in(monkeys, [target_monkey_id, :items], &(&1 ++ [worry_level]))
    end)
    |> put_in([monkey_id, :items], [])
  end
end
