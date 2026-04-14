# @manual
defmodule Unsent.Settings do
  @moduledoc """
  Client for team settings operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Retrieve team settings.

  ## Examples

      {:ok, settings} = Unsent.Settings.get(client)
      IO.inspect(settings)
  """
  @spec get(Client.t()) :: {:ok, Types.GetSettings200Response.t()} | {:error, any()}
  def get(client) do
    Client.get(client, "/settings")
  end
end
