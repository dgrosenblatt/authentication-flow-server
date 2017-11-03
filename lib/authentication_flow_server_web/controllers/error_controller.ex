defmodule AuthenticationFlowServerWeb.ErrorController do
  use AuthenticationFlowServerWeb, :controller
  alias AuthenticationFlowServerWeb.ErrorView
  alias Ecto.Changeset

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> assign(:changeset, changeset)
    |> put_status(:unprocessable_entity)
    |> render(ErrorView, "422.json")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(ErrorView, "401.json")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ErrorView, "404.json")
  end

  def call(conn, _) do
    conn
    |> put_status(:internal_server_error)
    |> render(ErrorView, "500.json")
  end
end
