defmodule Unsent.ProviderConnections do
  @moduledoc """
  Client for provider-connections operations.
  """

  alias Unsent.Client

  @spec list(Client.t()) :: {:ok, any()} | {:error, any()}
  def list(client) do
    Client.get(client, "/provider-connections")
  end

  @spec create(Client.t(), map()) :: {:ok, any()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/provider-connections", payload)
  end

  @spec delete(Client.t(), String.t()) :: {:ok, any()} | {:error, any()}
  def delete(client, id) do
    Client.delete(client, "/provider-connections/#{id}")
  end
end
