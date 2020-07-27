defmodule EscriptTestbed.CLI do
  @moduledoc """
  `EscriptTestbed.CLI` is the entry point for both the Mix task and the escript.
  Execute `./escript_testbed help` for details.
  """

  alias EscriptTestbed.Introspection
  alias EscriptTestbed.Scenario

  @command_aliases %{
    "s" => "sync",
    "l" => "list"
  }

  @doc false
  def main(argv, opts \\ []) do
    argv
    |> OptionParser.parse(
      strict: [help: :boolean],
      aliases: [h: :help]
    )
    |> replace_command_alias()
    |> convert_to_command()
    |> execute_command(opts)
  end

  defp replace_command_alias({switches, [command_or_alias | params], invalid}) do
    command = @command_aliases[command_or_alias] || command_or_alias
    {switches, [command | params], invalid}
  end

  defp replace_command_alias(tuple), do: tuple

  defp convert_to_command({[help: true], _, _}), do: :help
  defp convert_to_command({_, ["sync", scenario], _}), do: {:sync, scenario}
  defp convert_to_command({_, ["list"], _}), do: :list
  defp convert_to_command(_), do: :help

  defp execute_command(:help, _) do
    IO.puts("""

      ███████╗██╗   ██╗███╗   ██╗    ██████╗
      ██╔════╝╚██╗ ██╔╝████╗  ██║   ██╔════╝
      ███████╗ ╚████╔╝ ██╔██╗ ██║   ██║
      ╚════██║  ╚██╔╝  ██║╚██╗██║   ██║
      ███████║██╗██║██╗██║ ╚████║██╗╚██████╗██╗
      ╚══════╝╚═╝╚═╝╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝

    Usage: ./escript_testbed <command> [command params] [options]

    Commands:

      <s>sync scenario
      executes the given sync scenario

      <l>list
      lists all the scenarios you can sync

    Options:
      --help show this help message
    """)
  end

  defp execute_command({:sync, term}, _) do
    :ok = Application.ensure_started(:escript_testbed)
    scenario = cli_param_to_scenario(term)

    if scenario do
      EscriptTestbed.Scenario.run(scenario)
    else
      IO.puts("No matching scenario found")
    end
  end

  defp execute_command(:list, _) do
    {:consolidated, all_scenarios} = EscriptTestbed.Scenario.__protocol__(:impls)

    if Enum.empty?(all_scenarios) do
      IO.puts("No scenarios available at this time")
    else
      IO.puts("Available scenarios:")

      all_scenarios
      |> Enum.map(&scenario_to_cli_param/1)
      |> Enum.each(&IO.puts("- #{&1}"))
    end
  end

  defp cli_param_to_scenario(term) do
    module_suffix = Macro.camelize(term) |> String.to_atom()
    module = Module.safe_concat([EscriptTestbed.Scenarios, module_suffix])
    module.new
  end

  defp scenario_to_cli_param(module) do
    module
    |> Atom.to_string()
    |> String.replace("Elixir.EscriptTestbed.", "")
    |> String.replace("Scenarios.", "")
    |> String.replace(".", "")
    |> Macro.underscore()
  end
end
