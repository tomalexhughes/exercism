defmodule BankAccount.Impl do
  @moduledoc """
  Abstractions for modifying GenServer state
  """

  def update_balance(balance, value), do: balance + value
end
