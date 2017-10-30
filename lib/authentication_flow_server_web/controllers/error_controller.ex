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
end
