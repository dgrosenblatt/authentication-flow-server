defmodule AuthenticationFlowServerWeb.ErrorView do
  use AuthenticationFlowServerWeb, :view
  alias Ecto.Changeset

  def render("400.json", _conn) do
    %{errors: "Bad Request"}
  end

  def render("401.json", _conn) do
    %{errors: "Unauthorized"}
  end

  def render("403.json", _conn) do
    %{errors: "Forbidden"}
  end

  def render("404.json", _conn) do
    %{errors: "Not found"}
  end

  def render("422.json", %{changeset: changeset}) do
    %{errors: full_error_sentence(changeset)}
  end

  def render("422.json", %{message: message}) do
    %{errors: message}
  end

  def render("500.json", _conn) do
    %{errors: "Internal server error"}
  end

  defp full_error_sentence(%Changeset{errors: errors}) do
    errors
    |> error_list
    |> Enum.join(", ")
  end

  defp error_list(errors) do
    Enum.map(errors, fn({key, {reason, _opts}}) ->
      key
      |> Atom.to_string
      |> String.capitalize
      |> Kernel.<>(" ")
      |> Kernel.<>(reason)
    end)
  end
end
