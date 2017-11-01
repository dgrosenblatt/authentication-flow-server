defmodule AuthenticationFlowServerWeb.Router do
  use AuthenticationFlowServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthenticationFlowServerWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create]
    resources "/authentications/google", GoogleAuthenticationController, only: [:create]
    resources "/authentications", AuthenticationController, only: [:create]
  end
end
