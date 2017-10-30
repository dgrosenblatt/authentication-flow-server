defmodule AuthenticationFlowServerWeb.ErrorViewTest do
  use AuthenticationFlowServerWeb.ConnCase, async: true
  import Phoenix.View
  alias AuthenticationFlowServer.Accounts.User

  test "renders 422.json" do
    invalid_changeset = User.changeset(%User{}, %{})
    assert %{errors: _} = render(
      AuthenticationFlowServerWeb.ErrorView,
      "422.json",
      %{changeset: invalid_changeset}
    )
  end
end
