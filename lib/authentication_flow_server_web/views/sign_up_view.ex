defmodule AuthenticationFlowServerWeb.SignUpView do
  use AuthenticationFlowServerWeb, :view

  def render("create.json", %{user_params: user_params}) do
    %{user: user_params}
  end
end
