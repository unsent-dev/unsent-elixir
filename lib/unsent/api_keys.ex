# @manual
defmodule Unsent.ApiKeys do
  @moduledoc """
  Client for API key management operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Retrieve a list of API keys for the current team.

  ## Examples

      {:ok, api_keys} = Unsent.ApiKeys.list(client)
  """
  @spec list(Client.t()) :: {:ok, list(Types.GetApiKeys200ResponseInner.t())} | {:error, any()}
  def list(client) do
    Client.get(client, "/api-keys")
  end

  @doc """
  Create a new API key for the current team.

  ## Parameters

    * `payload` - Map containing:
      * `:name` (required) - Name of the API key
      * `:permission` (optional) - Permission level: "FULL" or "SENDING" (default: "FULL")

  ## Examples

      {:ok, api_key} = Unsent.ApiKeys.create(client, %{
        name: "Production API Key",
        permission: "FULL"
      })

      {:ok, api_key} = Unsent.ApiKeys.create(client, %{
        name: "Sending Only Key",
        permission: "SENDING"
      })
  """
  @spec create(Client.t(), Types.CreateApiKeyRequest.t() | map()) :: {:ok, Types.CreateApiKey200Response.t()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/api-keys", payload)
  end

  @doc """
  Delete an API key by ID.

  ## Examples

      {:ok, _} = Unsent.ApiKeys.delete(client, "key_123")
  """
  @spec delete(Client.t(), String.t()) :: {:ok, map() | nil} | {:error, any()}
  def delete(client, id) do
    Client.delete(client, "/api-keys/#{id}")
  end
end
