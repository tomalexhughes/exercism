defmodule BirdCount do
  def today([]), do: nil
  def today([h | _]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  def total(list, total \\ 0)
  def total([], total), do: total
  def total([head | tail], total), do: total(tail, total + head)

  def busy_days(list, count \\ 0)
  def busy_days([], count), do: count
  def busy_days([head | tail], count) when head >= 5, do: busy_days(tail, count + 1)
  def busy_days([_head | tail], count), do: busy_days(tail, count)
end
