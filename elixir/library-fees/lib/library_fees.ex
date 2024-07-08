defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime |> NaiveDateTime.to_time() |> Time.compare(~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    Date.add(checkout_datetime, days_to_add)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    days_late = Date.diff(actual_return_datetime, planned_return_date)
    max(days_late, 0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = checkout |> datetime_from_string()
    return_due_datetime = checkout_datetime |> return_date()
    actual_return_datetime = return |> datetime_from_string()

    days_late = days_late(return_due_datetime, actual_return_datetime)

    late_fee = days_late * rate
    if monday?(actual_return_datetime), do: floor(late_fee * 0.5), else: late_fee
  end
end
