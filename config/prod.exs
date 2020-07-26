use Mix.Config

config :logger, level: :error

config :escript_testbed, EscriptTestbed.Repos.Source,
  adapter: {:system, :string, "ETB_SOURCE_REPO_ADAPTER"},
  url: {:system, :string, "ETB_SOURCE_REPO_DATABASE_URL"},
  ssl: {:system, :boolean, "ETB_SOURCE_REPO_SSL", false}

config :escript_testbed, EscriptTestbed.Repos.Destination,
  adapter: {:system, :string, "ETB_DESTINATION_REPO_ADAPTER"},
  url: {:system, :string, "ETB_DESTINATION_REPO_DATABASE_URL"},
  ssl: {:system, :boolean, "ETB_DESTINATION_REPO_SSL", false}
