defmodule Lasagna do
  @layer_preparation_time 2

  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(current_minutes), do: expected_minutes_in_oven() - current_minutes

  def preparation_time_in_minutes(layers), do: layers * @layer_preparation_time

  def total_time_in_minutes(layers, current_minutes),
    do: preparation_time_in_minutes(layers) + current_minutes

  def alarm, do: "Ding!"
end
