defmodule AuthenticationFlowServer.Accounts.PasswordReset.RedemptionTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.Accounts.{PasswordReset, PasswordReset.Redemption}
  alias Calendar.DateTime

  @hour_from_now DateTime.add!(DateTime.now_utc(), 3600)
  @hour_ago DateTime.subtract!(DateTime.now_utc(), 3600)

  describe "redeem_with_token/1" do
    @tag :current
    test "returns a password reset and sets redeemed at to the current time" do
      token = "abc-123"
      password_reset_id = insert(:password_reset, token: token, redeemed_at: nil).id

      assert {:ok, %PasswordReset{
        id: ^password_reset_id,
        redeemed_at: redeemed_at
      }} = Redemption.redeem_with_token(token)

      refute is_nil(redeemed_at)
    end

    @tag :current
    test "returns an error when no PasswordReset is associated with the token" do
      assert {:error, :not_found} = Redemption.redeem_with_token("fake-token")
    end

    @tag :current
    test "returns an error when the PasswordReset is expired" do
      token = "abc-123"
      insert(:password_reset,
        token: token, redeemed_at: nil, expired_at: @hour_ago)

      assert {:error, :password_reset_token_expired} = Redemption.redeem_with_token(token)
    end

    @tag :current
    test "returns an error when the Password reset is redeemed" do
      token = "abc-123"
      insert(:password_reset,
        token: token, redeemed_at: DateTime.now_utc(), expired_at: @hour_from_now)

      assert {:error, :password_reset_token_redeemed} = Redemption.redeem_with_token(token)
    end
  end
end
