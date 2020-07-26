defmodule EscriptTestbed.MixProject do
  use Mix.Project

  def project do
    [
      app: :escript_testbed,
      version: "0.0.1",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: [main_module: EscriptTestbed.CLI],
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "External Data Sync",
      source_url: "https://github.com/elvanja/escript_testbed",
      docs: [
        main: "readme",
        extras: ["README.md"],
        groups_for_modules: [],
        nest_modules_by_prefix: []
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  def application do
    [
      extra_applications: [:logger],
      mod: {EscriptTestbed.Application, []}
    ]
  end

  defp deps do
    [
      {:confex, "~> 3.4.0"},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.4"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:jason, "~> 1.2"},
      {:paginator, "~> 0.6.0"},
      {:myxql, "~> 0.3.0"},
      {:postgrex, ">= 0.0.0"}
    ]
  end
end
