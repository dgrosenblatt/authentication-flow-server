# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :authentication_flow_server,
  ecto_repos: [AuthenticationFlowServer.Repo]

# Configures the endpoint
config :authentication_flow_server, AuthenticationFlowServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "KEG4P8yKVfrniRpTeVKdGHnlIC3yceN8AnwL+wfKHGKZ/qP3iZDwD+0h7C7BOeTh",
  render_errors: [view: AuthenticationFlowServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthenticationFlowServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :authentication_flow_server,
  sender_email: System.get_env("SENDER_EMAIL"),
  ios_app_url_identifier: System.get_env("IOS_APP_URL_IDENTIFIER"),
  sendgrid_api_key: System.get_env("SENDGRID_API_KEY")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "AuthenticationFlowServer",
  ttl: { 30, :days },
  verify_issuer: true,
  serializer: AuthenticationFlowServer.GuardianSerializer

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY"),
  s3_bucket: System.get_env("AWS_S3_BUCKET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
