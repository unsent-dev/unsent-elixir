# @manual
defmodule Unsent.System do
  @moduledoc """
  Client for system operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Check API health status.

  ## Examples

      {:ok, health} = Unsent.System.health(client)
      # => %{"status" => "ok", "uptime" => 12345, "timestamp" => 1234567890}
  """
  @spec health(Client.t()) :: {:ok, Types.GetHealth200Response.t()} | {:error, any()}
  def health(client) do
    Client.get(client, "/health")
  end

  @doc """
  Get API version information.

  ## Examples

      {:ok, version} = Unsent.System.version(client)
      # => %{"version" => "1.0.0", "environment" => "production", ...}
  """
  @spec version(Client.t()) :: {:ok, Types.GetVersion200Response.t()} | {:error, any()}
  def version(client) do
    Client.get(client, "/version")
  end
end
