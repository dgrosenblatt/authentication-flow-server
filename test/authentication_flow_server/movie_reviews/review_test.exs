defmodule AuthenticationFlowServer.MovieReviews.ReviewTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.MovieReviews.Review

  describe "changeset/2" do
    test "with valid params" do
      user = insert(:user)
      movie = insert(:movie)
      params = %{
        "user_id" => user.id,
        "movie_id" => movie.id,
        "body" => "It was pretty good",
        "rating" => 3
      }

      changeset = Review.changeset(%Review{}, params)
      assert changeset.valid? == true
    end

    test "with missing required param" do
      params = %{
        "user_id" => 0,
        "movie_id" => 0,
        "body" => "",
        "rating" => ""
      }
      changeset = Review.changeset(%Review{}, params)
      assert changeset.valid? == false
    end
  end
end
