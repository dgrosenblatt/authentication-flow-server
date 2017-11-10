defmodule AuthenticationFlowServer.Accounts.PasswordReset.Redemption do
  @moduledoc """
  Functions for redeeming password resets
  """

  alias AuthenticationFlowServer.{Accounts.PasswordReset, Repo}
  alias Calendar.DateTime

  @spec redeem_with_token(String.t) :: {:ok, PasswordReset.t} | {:error, Repo.Changeset.t} | {:error, atom}
  def redeem_with_token(token) do
    password_reset = determine_redeemable(token)

    case password_reset do
      %PasswordReset{} = password_reset -> redeem(password_reset)
      {:error, _} = error -> error
    end
  end

  defp redeem(password_reset) do
    password_reset
    |> PasswordReset.changeset(%{redeemed_at: DateTime.now_utc()})
    |> Repo.update
  end

  defp determine_redeemable(token) do
    password_reset = Repo.get_by(PasswordReset, token: token)

    cond do
      password_reset == nil -> {:error, :not_found}
      expired?(password_reset) -> {:error, :password_reset_token_expired}
      redeemed?(password_reset) -> {:error, :password_reset_token_redeemed}
      true -> password_reset
    end
  end

  defp redeemed?(%{redeemed_at: redeemed_at}), do: !is_nil(redeemed_at)

  defp expired?(%{expired_at: expired_at}) do
    {:ok, expired_at_dt} = DateTime.from_naive(expired_at, "Etc/UTC")
    DateTime.before?(expired_at_dt, DateTime.now_utc())
  end
end
