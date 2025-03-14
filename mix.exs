defmodule AuthenticationFlowServer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :authentication_flow_server,
      version: "0.0.1",
      elixir: "~> 1.5.0",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {AuthenticationFlowServer.Application, []},
      extra_applications: [
        :ex_machina,
        :logger,
        :runtime_tools,
        :httpoison,
        :poison]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bcrypt_elixir, "~> 0.12"},
      {:calendar, "~> 0.17.4"},
      {:comeonin, "~> 4.0.3"},
      {:cowboy, "~> 1.0"},
      {:ex_aws, "~> 2.0.1"},
      {:ex_aws_s3, "~> 2.0.0"},
      {:ex_machina, "~> 2.0"},
      {:fastglobal, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:guardian, "~> 0.14.5"},
      {:httpoison, "~> 0.13.0"},
      {:joken, "~> 1.1"},
      {:mock, "~> 0.2.0", only: :test},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:postgrex, ">= 0.0.0"},
      {:poison, "~> 2.0"},
      {:sweet_xml, "~> 0.6.5"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
