defmodule KitchenCalculator do
  @volume_mls %{
    :cup => 240,
    :fluid_ounce => 30,
    :teaspoon => 5,
    :tablespoon => 15,
    :milliliter => 1
  }

  def get_volume({_name, volume}) do
    volume
  end

  # The exercise asks for multiple function clauses with pattern matching
  # however this seems neater
  def to_milliliter({name, volume}) do
    {_, volume_mls} = Map.fetch(@volume_mls, name)
    {:milliliter, volume * volume_mls}
  end

  # Just like `to_milliliter` - we have used a single function clause here
  def from_milliliter({_name, volume}, unit) do
    {_, volume_mls} = Map.fetch(@volume_mls, unit)
    {unit, volume / volume_mls}
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
