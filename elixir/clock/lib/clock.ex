defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock

  def new(hour, minute) when minute < 0 do
    new(hour - 1, 60 + minute)
  end

  def new(hour, minute) when hour < 0 do
    new(24 + hour, minute)
  end

  def new(hour, minute) when minute >= 60 do
    new(hour + 1, minute - 60)
  end

  def new(hour, minute) when hour >= 24 do
    new(hour - 24, minute)
  end

  def new(24, minute) do
    new(0, minute)
  end

  def new(hour, minute) do
    %Clock{hour: hour, minute: minute}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(clock) do
    String.pad_leading(Integer.to_string(clock.hour), 2, "0") <>
      ":" <> String.pad_leading(Integer.to_string(clock.minute), 2, "0")
  end
end
