defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    if account_open_check(account),
      do: GenServer.call(account, :get_balance),
      else: account_closed
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    if account_open_check(account),
      do: GenServer.call(account, {:update_balance, amount}),
      else: account_closed
  end

  @doc """
  Checks whether an account is currently open.
  """
  @spec account_open_check(account) :: Boolean
  defp account_open_check(account) do
    Process.alive?(account)
  end

  @doc """
  Return an account_closed error.
  """
  defp account_closed do
    {:error, :account_closed}
  end

  # Server (callbacks)
  @impl true
  def init(value) do
    {:ok, value}
  end

  # @impl true
  def handle_call(:get_balance, _from, state) do
    {:reply, state, state}
  end

  # @impl true
  def handle_call({:update_balance, value}, _from, state) do
    updated_balance = value + state
    {:reply, updated_balance, updated_balance}
  end
end
