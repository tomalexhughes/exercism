defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, pid} = Agent.start(fn -> 0 end)
    pid
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    Agent.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    case Process.alive?(account) do
      true -> Agent.get(account, fn balance -> balance end)
      false -> {:error, :account_closed}
    end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) do
    with true <- Process.alive?(account) || {:error, :account_closed},
         true <- amount > 0 || {:error, :amount_must_be_positive} do
      Agent.get_and_update(account, fn balance -> {:ok, balance + amount} end)
    end
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) do
    with true <- Process.alive?(account) || {:error, :account_closed},
         true <- amount > 0 || {:error, :amount_must_be_positive} do
      Agent.get_and_update(account, fn balance ->
        cond do
          balance < amount -> {{:error, :not_enough_balance}, balance}
          true -> {:ok, balance - amount}
        end
      end)
    end
  end
end
