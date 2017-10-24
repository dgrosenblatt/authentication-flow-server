defmodule AuthenticationFlowServerWeb.Router do
  use AuthenticationFlowServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthenticationFlowServerWeb do
    pipe_through :api

    resources "/sign_ups", SignUpController, only: [:create]
  end
end
