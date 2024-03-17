defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight, bag_value \\ 0)
  def maximum_value([], _maximum_weight, bag_value), do: bag_value

  def maximum_value([%{weight: weight} | tail], maximum_weight, bag_value)
      when weight > maximum_weight,
      do: maximum_value(tail, maximum_weight, bag_value)

  def maximum_value([head | tail], maximum_weight, bag_value) do
    value_with_item =
      maximum_value(tail, maximum_weight - head[:weight], bag_value + head[:value])

    value_without_item = maximum_value(tail, maximum_weight, bag_value)

    max(value_with_item, value_without_item)
  end
end
