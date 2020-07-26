use Mix.Config

config :logger,
  backends: [:console],
  level: :warning,
  utc_log: true

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:mfa]

import_config "#{Mix.env()}.exs"
