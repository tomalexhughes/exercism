defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value(items, maximum_weight, bag_value \\ 0)
  def maximum_value([], _maximum_weight, bag_value), do: bag_value
  def maximum_value(_list, 0, bag_value), do: bag_value

  def maximum_value([head | tail], maximum_weight, bag_value) do
    cond do
      !has_item_under_weight_limit?([head | tail], maximum_weight) ->
        maximum_value([], maximum_weight, bag_value)

      !is_item_under_weight_limit?(head, maximum_weight) ->
        maximum_value(tail, maximum_weight, bag_value)

      true ->
        value_with_item =
          maximum_value(tail, maximum_weight - head[:weight], bag_value + head[:value])

        value_without_item = maximum_value(tail, maximum_weight, bag_value)

        max(value_with_item, value_without_item)
    end
  end

  defp is_item_under_weight_limit?(item, maximum_weight) do
    item[:weight] <= maximum_weight
  end

  defp has_item_under_weight_limit?(items, maximum_weight) do
    Enum.any?(items, &is_item_under_weight_limit?(&1, maximum_weight))
  end
end
