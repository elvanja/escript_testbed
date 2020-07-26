defmodule EscriptTestbed.Application do
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    Confex.resolve_env!(:escript_testbed)

    children = [
      build_repo_spec(EscriptTestbed.Repos.Source, :source),
      build_repo_spec(EscriptTestbed.Repos.Destination, :destination)
    ]

    Logger.debug(inspect(children, pretty: true))

    opts = [strategy: :one_for_one, name: EscriptTestbed.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp build_repo_spec(name, target) do
    opts = Application.get_env(:escript_testbed, name)

    adapter =
      case opts[:adapter] do
        "postgres" ->
          Ecto.Adapters.Postgres

        "mysql" ->
          Ecto.Adapters.MyXQL

        adapter ->
          raise(ArgumentError, message: "Unsupported #{target} repo adapter: #{adapter}")
      end

    build_repo_module(name, target, adapter)

    Supervisor.child_spec({name, opts}, id: name)
  end

  defp build_repo_module(name, :source, adapter) do
    module_body =
      Code.string_to_quoted!("""
        use Ecto.Repo,
          otp_app: :escript_testbed,
          adapter: #{adapter},
          read_only: true

        use Paginator,
          limit: 1000,
          maximum_limit: 100_000
      """)

    {:module, ^name, _, _} =
      Module.create(name, module_body, Macro.Env.location(__ENV__))
  end

  defp build_repo_module(name, :destination, adapter) do
    module_body =
      Code.string_to_quoted!("""
        use Ecto.Repo,
          otp_app: :escript_testbed,
          adapter: #{adapter}
      """)

    {:module, ^name, _, _} =
      Module.create(name, module_body, Macro.Env.location(__ENV__))
  end
end
