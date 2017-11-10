defmodule AuthenticationFlowServerWeb.RedeemPasswordResetView do
  use AuthenticationFlowServerWeb, :view

  def render("user.json", %{user: user, token: token}) do
    %{user: %{email: user.email}, token: token}
  end
end
