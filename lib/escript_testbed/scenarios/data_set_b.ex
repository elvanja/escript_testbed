defmodule EscriptTestbed.Scenarios.DataSetB do
  @moduledoc false

  alias EscriptTestbed.Repos.Destination, as: DestinationRepo
  alias EscriptTestbed.Repos.Source, as: SourceRepo
  alias EscriptTestbed.Scenario

  @behaviour Scenario

  @impl Scenario
  def run do
    IO.puts("""
    Sync completed successfully:
    - scenario: #{__MODULE__}
    - source:
      - #{SourceRepo.__adapter__()}
      - #{inspect(SourceRepo.config())}
    - destination:
      - #{DestinationRepo.__adapter__()}
      - #{inspect(DestinationRepo.config())}
    """)
  end
end

defimpl EscriptTestbed.Scenario, for: EscriptTestbed.Scenarios.DataSetB do
  def run(_) do
    EscriptTestbed.Scenarios.DataSetB.run()
  end
end
