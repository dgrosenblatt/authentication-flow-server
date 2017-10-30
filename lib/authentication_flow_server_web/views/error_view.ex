defmodule AuthenticationFlowServerWeb.ErrorView do
  use AuthenticationFlowServerWeb, :view
  alias Ecto.Changeset

  def render("422.json", %{changeset: changeset}) do
    %{errors: full_error_sentence(changeset)}
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
