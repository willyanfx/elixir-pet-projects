defmodule Rocketpay.Accounts.Deposit do
  alias Ecto.Multi
  alias Rocketpay.{Account, Repo}

  def call(%{"id" => id, "value" => value}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->
      update_balance(repo, account, value)
    end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account, not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value) do
    account
    |> sum_values(value)
    |> update_account(repo)
  end

  defp sum_values(%Account{balance: balance}, value) do
    value
    # cast tenta convert qualquer valor para decimal
    |> Decimal.cast()
    |> hanlde_cast(balance)
  end

  defp hanlde_cast({:ok, value}), do: Decimal.add(value, balance)
  defp hanlde_cast({:error, _balance}), do: {:error, "Invalid deposit value!"}
end
