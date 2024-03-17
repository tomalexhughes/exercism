defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _), do: 0

  def maximum_value([hd | tl], maximum_weight) when hd.weight > maximum_weight,
    do: maximum_value(tl, maximum_weight)

  def maximum_value([hd | tl], maximum_weight) do
    value_with_item = hd.value + maximum_value(tl, maximum_weight - hd.weight)
    value_without_item = maximum_value(tl, maximum_weight)
    max(value_with_item, value_without_item)
  end
end
