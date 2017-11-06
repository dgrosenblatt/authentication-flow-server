defmodule AuthenticationFlowServer.MovieReviewsTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.{MovieReviews, MovieReviews.Review}

  describe "create_review/1" do
    test "persists and returns a Review" do
      user = insert(:user)
      user_id = user.id
      movie = insert(:movie)
      movie_id = movie.id

      params = %{
        "user_id" => user_id,
        "movie_id" => movie_id,
        "body" => "It was pretty good",
        "rating" => 3
      }

      {:ok, review} = MovieReviews.create_review(params)
      review_count = Repo.aggregate(Review, :count, :id)

      assert review_count == 1
      assert %Review{
        user_id: ^user_id,
        movie_id: ^movie_id,
        rating: 3,
        body: "It was pretty good",
      } = review
    end
  end

  describe "delete_review/1" do
  @tag :current
    test "deletes a Review" do
      review = insert(:review)
      MovieReviews.delete_review(review)
      review_count = Repo.aggregate(Review, :count, :id)
      assert review_count == 0
    end
  end
end
