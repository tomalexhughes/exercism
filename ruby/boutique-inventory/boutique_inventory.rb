class BoutiqueInventory
  def initialize(items)
    @items = items
  end

  def item_names
    @items.map { |item| item[:name] }.sort
  end

  def cheap
    maximum_cost = 29.99
    @items.filter { |item| item[:price] <= maximum_cost }
  end

  def out_of_stock
    @items.filter { |item| item[:quantity_by_size] == {} }
  end

  def stock_for_item(name)
    @items.find { |item| item[:name] == name }[:quantity_by_size]
  end

  def total_stock
    @items.map { |item| item[:quantity_by_size].values.sum }.sum
  end

  private

  attr_reader :items
end
