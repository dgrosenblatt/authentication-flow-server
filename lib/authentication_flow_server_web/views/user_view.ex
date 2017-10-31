defmodule AuthenticationFlowServerWeb.UserView do
  use AuthenticationFlowServerWeb, :view

  def render("create.json", %{user: user, token: token}) do
    %{user: %{email: user.email}, token: token}
  end
end
