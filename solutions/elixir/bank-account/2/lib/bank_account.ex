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
  @spec close(account) :: :ok
  def close(account) when is_pid(account), do: Agent.stop(account)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) when is_pid(account) do
    with(
      true <- Process.alive?(account) or {:error, :account_closed},
      do: Agent.get(account, & &1)
    )
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) when is_pid(account) and is_integer(amount) do
    with(
      true <- Process.alive?(account) or {:error, :account_closed},
      true <- amount > 0 or {:error, :amount_must_be_positive},
      do: Agent.get_and_update(account, fn balance -> {:ok, balance + amount} end)
    )
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) when is_pid(account) and is_integer(amount) do
    with(
      true <- Process.alive?(account) or {:error, :account_closed},
      true <- amount > 0 or {:error, :amount_must_be_positive},
      do:
        Agent.get_and_update(account, fn
          balance when balance >= amount -> {:ok, balance - amount}
          insufficient -> {{:error, :not_enough_balance}, insufficient}
        end)
    )
  end
end
