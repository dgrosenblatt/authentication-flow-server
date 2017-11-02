defmodule AuthenticationFlowServer.Factory do
  use ExMachina.Ecto, repo: AuthenticationFlowServer.Repo
  alias AuthenticationFlowServer.Accounts.User
  alias AuthenticationFlowServer.MovieReviews.{Actor, Director, Movie, Review, Role}

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      encrypted_password: sequence(:encrypted_password, &"encrypted_password_#{&1}")
    }
  end

  def movie_factory do
    %Movie{
      name: "Toy Story",
      release_date: ~D[1995-11-22],
      director: build(:director)
    }
  end

  def director_factory do
    %Director{name: "John Lasseter"}
  end

  def actor_factory do
    %Actor{name: "Tom Hanks"}
  end

  def role_factory do
    %Role{movie: build(:movie), actor: build(:actor)}
  end

  def review_factory do
    %Review{
      user: build(:user),
      movie: build(:movie),
      rating: 10,
      body: "It was really good"
    }
  end
end
