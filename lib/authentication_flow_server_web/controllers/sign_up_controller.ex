defmodule AuthenticationFlowServerWeb.SignUpController do
  use AuthenticationFlowServerWeb, :controller

  def create(conn, %{"user" => user_params}) do
    conn
    |> assign(:user_params, user_params)
    |> put_status(:created)
    |> render("create.json")
  end
end
