defmodule BankAccount.Server do
  use GenServer
  alias BankAccount.Impl

  @impl true
  def init(value) do
    {:ok, value}
  end

  @impl true
  def handle_call(:get_balance, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:update_balance, value}, _from, state) do
    updated_balance = Impl.update_balance(state, value)
    {:reply, updated_balance, updated_balance}
  end
end
