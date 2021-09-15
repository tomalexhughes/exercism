defmodule FreelancerRates do
  @working_hours_per_day 8.0
  @working_days_per_month 22

  def daily_rate(hourly_rate), do: hourly_rate * @working_hours_per_day
  def apply_discount(before_discount, discount), do: before_discount * (1 - discount / 100)

  def monthly_rate(hourly_rate, discount),
    do:
      daily_rate(hourly_rate)
      |> apply_discount(discount)
      |> Kernel.*(@working_days_per_month)
      |> Float.ceil()
      |> Kernel.trunc()

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> (fn discounted_day_rate -> budget / discounted_day_rate end).()
    |> Float.floor(1)
  end
end
