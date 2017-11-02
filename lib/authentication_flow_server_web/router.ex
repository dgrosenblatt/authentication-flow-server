defmodule AuthenticationFlowServerWeb.Router do
  use AuthenticationFlowServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", AuthenticationFlowServerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/authentications/google", GoogleAuthenticationController, only: [:create]
    resources "/authentications", AuthenticationController, only: [:create]
  end

  scope "/v1", AuthenticationFlowServerWeb do
    pipe_through :api
    pipe_through :api_auth

    resources "/movies", MovieController, only: [:index]
  end

  scope "/v2", AuthenticationFlowServerWeb do
    pipe_through :api
    pipe_through :api_auth

    resources "/movies", MovieController, only: [:index]
  end
end
