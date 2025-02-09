defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    increase_by_1 = fn {k, v} -> {k, v + count} end
    quantity_by_size = Map.new(item.quantity_by_size, increase_by_1)

    %{item | quantity_by_size: quantity_by_size}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_k, v}, acc -> acc + v end)
  end
end
