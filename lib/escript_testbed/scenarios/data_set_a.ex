defmodule EscriptTestbed.Scenarios.DataSetA do
  @moduledoc false

  alias EscriptTestbed.Repos.Destination, as: DestinationRepo
  alias EscriptTestbed.Repos.Source, as: SourceRepo
  alias EscriptTestbed.Scenario

  @behaviour Scenario

  defstruct key_1: nil, key_2: nil

  def new(), do: %__MODULE__{}

  @impl Scenario
  def run(scenario) do
    IO.puts("""
    Sync completed successfully:
    - scenario: #{inspect(scenario)}
    """)
  end
end

defimpl EscriptTestbed.Scenario, for: EscriptTestbed.Scenarios.DataSetA do
  def run(scenario) do
    EscriptTestbed.Scenarios.DataSetA.run(scenario)
  end
end
