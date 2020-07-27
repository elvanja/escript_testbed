defmodule EscriptTestbed.Scenarios.DataSetB do
  @moduledoc false

  alias EscriptTestbed.Repos.Destination, as: DestinationRepo
  alias EscriptTestbed.Repos.Source, as: SourceRepo
  alias EscriptTestbed.Scenario

  @behaviour Scenario

  defstruct key_3: nil, key_4: nil

  def new(), do: %__MODULE__{}

  @impl Scenario
  def run(scenario) do
    IO.puts("""
    Sync completed successfully:
    - scenario: #{inspect(scenario)}
    """)
  end
end

defimpl EscriptTestbed.Scenario, for: EscriptTestbed.Scenarios.DataSetB do
  def run(scenario) do
    EscriptTestbed.Scenarios.DataSetB.run(scenario)
  end
end
