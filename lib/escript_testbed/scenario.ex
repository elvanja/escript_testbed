defmodule EscriptTestbed.Scenario do
  @moduledoc """
  Common behaviour for all scenarios.
  """

  @doc "Invokes the sync scenario execution"
  @callback run() :: any()
end
