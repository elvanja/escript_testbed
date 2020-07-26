defmodule Mix.Tasks.EscriptTestbed do
  use Mix.Task

  @shortdoc "Run data sync (use `--help` for options)"
  @moduledoc @shortdoc

  # credo:disable-for-lines:5 Credo.Check.Design.AliasUsage
  @doc false
  def run(argv) do
    EscriptTestbed.CLI.main(argv)
  end
end
