defmodule AuthenticationFlowServer.MovieReviewsTest do
  use AuthenticationFlowServer.DataCase
  alias AuthenticationFlowServer.Accounts.User
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

      assert {:ok, %Review{
        user_id: ^user_id,
        movie_id: ^movie_id,
        rating: 3,
        body: "It was pretty good",
      }} = MovieReviews.create_review(params)
      assert Repo.aggregate(Review, :count, :id) == 1
    end

    test "returns an error and changeset if the associated movie does not exist" do
      user = insert(:user)
      params = %{
        "user_id" => user.id,
        "movie_id" => 888,
        "body" => "It was pretty good",
        "rating" => 3
      }

      {:error, _changeset} = MovieReviews.create_review(params)
    end
  end

  describe "delete_review/1" do
    test "deletes a Review" do
      review = insert(:review)
      MovieReviews.delete_review(review)
      review_count = Repo.aggregate(Review, :count, :id)
      assert review_count == 0
    end
  end

  describe "update_review/2" do
    test "updates a review" do
      review = insert(:review)
      new_body = "It actually wasn't great"
      new_rating = 2
      params = %{"body" => new_body, "rating" => new_rating}

      {:ok, review} = MovieReviews.update_review(review, params)
      assert %Review{
        body: ^new_body,
        rating: ^new_rating
      } = review
    end
  end

  describe "all_reviews_for_user/1" do
    test "returns a list of reviews associated with a given user" do
      user = insert(:user)
      insert_list(3, :review, user: user)
      other_review = insert(:review)
      reviews = MovieReviews.all_reviews_for_user(user)

      Enum.each(reviews, &(assert Enum.member?(reviews, &1)))
      refute Enum.member?(reviews, other_review)
    end
  end

  describe "get_review_by_id_for_user/2" do
    test "returns a tuple with :ok and the review" do
      user = insert(:user)
      review = insert(:review, user: user)
      review_id = review.id
      assert {:ok, %Review{id: ^review_id}} =
        MovieReviews.get_review_by_id_for_user(review_id, user)
    end

    test "returns an error if nothing found" do
      user = %User{id: 1}
      assert {:error, :not_found} = MovieReviews.get_review_by_id_for_user(1, user)
    end

    test "returns an error if review found but not owned by user" do
      user = insert(:user)
      review = insert(:review)
      assert {:error, :forbidden} =
        MovieReviews.get_review_by_id_for_user(review.id, user)
    end
  end
end
