defmodule AuthenticationFlowServer.Repo.Query do
  alias AuthenticationFlowServer.Repo

  def get_or_insert!(module, attrs \\ %{}) do
    case Repo.get_by(module, attrs) do
      nil ->
        module
        |> struct(attrs)
        |> Repo.insert!
      record ->
        record
    end
  end
end
