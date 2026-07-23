defmodule BankAccount do
  use GenServer

  def open do
    {:ok, pid} = GenServer.start_link(__MODULE__, :ok)
    pid
  end

  def init(:ok), do: {:ok, %{balance: 0, status: :open}}

  def close(account), do: GenServer.call(account, :close)

  def balance(account), do: GenServer.call(account, :balance)

  def deposit(account, amount), do: GenServer.call(account, {:deposit, amount})

  def withdraw(account, amount), do: GenServer.call(account, {:withdraw, amount})

  def handle_call(:balance, _from, %{status: :open, balance: bal} = state), do: {:reply, bal, state}
  def handle_call(:balance, _from, %{status: :closed} = state), do: {:reply, {:error, :account_closed}, state}
  def handle_call({:deposit, amount}, _from, %{status: :closed} = state), do: {:reply, {:error, :account_closed}, state}
  def handle_call({:deposit, amount}, _from, %{status: :open, balance: bal} = state)
    when is_integer(amount) and amount > 0 do
      new_state = %{state | balance: bal + amount}
      {:reply, :ok, new_state}
  end
  def handle_call({:deposit, _amount}, _from, state), do: {:reply, {:error, :amount_must_be_positive}, state}
  def handle_call({:withdraw, _amount}, _from, %{status: :closed} = state), do: {:reply, {:error, :account_closed}, state}
  def handle_call({:withdraw, amount}, _from, %{status: :open, balance: bal} = state)
      when is_integer(amount) and amount > 0 and amount <= bal do
    new_state = %{state | balance: bal - amount}
    {:reply, :ok, new_state}
  end
  def handle_call({:withdraw, amount}, _from, %{status: :open, balance: bal} = state)
      when is_integer(amount) and amount > 0 and amount > bal do
    {:reply, {:error, :not_enough_balance}, state}
  end
  def handle_call({:withdraw, _amount}, _from, state), do: {:reply, {:error, :amount_must_be_positive}, state}
  def handle_call(:close, _from, state), do: {:reply, :ok, %{state | status: :closed}}
end