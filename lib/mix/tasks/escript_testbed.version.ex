defmodule Mix.Tasks.EscriptTestbed.Version do
  use Mix.Task

  @shortdoc "Shows project version"
  @moduledoc @shortdoc

  # credo:disable-for-lines:5 Credo.Check.Design.AliasUsage
  @doc false
  def run(_) do
    IO.puts(Mix.Project.config()[:version])
  end
end
