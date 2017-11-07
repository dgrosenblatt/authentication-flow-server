defmodule AuthenticationFlowServer.Repo.QueryTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.{MovieReviews.Actor, Repo}

  describe "get_or_insert!/1" do
    test "inserts a new record if it does not exist yet" do
      name = "Tom Hanks"
      actor = Repo.Query.get_or_insert!(Actor, %{name: name})
      assert %{name: ^name} = actor
      assert Repo.aggregate(Actor, :count, :id) == 1
    end

    test "returns a matching record without persisting anything new" do
      name = "Tom Hanks"
      insert(:actor, name: name)
      actor = Repo.Query.get_or_insert!(Actor, %{name: name})
      assert %{name: ^name} = actor
      assert Repo.aggregate(Actor, :count, :id) == 1
    end
  end
end
