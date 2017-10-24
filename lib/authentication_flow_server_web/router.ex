defmodule AuthenticationFlowServerWeb.Router do
  use AuthenticationFlowServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AuthenticationFlowServerWeb do

  end
end
