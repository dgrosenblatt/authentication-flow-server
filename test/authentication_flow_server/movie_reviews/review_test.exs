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

  describe "update_changeset/2" do
    test "with valid params" do
      review = insert(:review)
      params = %{"body" => "It actually wasn't that good", "rating" => 1}
      changeset = Review.update_changeset(review, params)
      assert changeset.valid? == true
    end

    test "only allows rating and body to be changed" do
      review = insert(:review)
      params = %{"body" => "new", "rating" => 1, "user_id" => 999, "movie_id" => 999}
      changeset = Review.update_changeset(review, params)
      assert changeset.changes == %{body: "new", rating: 1}
    end
  end
end
