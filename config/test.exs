use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :authentication_flow_server, AuthenticationFlowServerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :authentication_flow_server, AuthenticationFlowServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  username: "postgres",
  password: "postgres",
  database: "authentication_flow_server_test",
  hostname: "localhost"

config :guardian, Guardian,
  secret_key: "This is a secret key"

config :authentication_flow_server, AuthenticationFlowServer.Mailer,
  adapter: Bamboo.TestAdapter

config :authentication_flow_server,
  sender_email: "test@email.com"
