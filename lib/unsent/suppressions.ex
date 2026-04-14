# @manual
defmodule Unsent.Suppressions do
  @moduledoc """
  Client for suppression list management operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  List suppressed emails.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number for pagination (default: 1)
      * `:limit` - Number of items per page (default: 20, max: 100)
      * `:search` - Search query string
      * `:reason` - Filter by suppression reason: "HARD_BOUNCE", "COMPLAINT", "MANUAL", or "UNSUBSCRIBE"

  ## Examples

      {:ok, suppressions} = Unsent.Suppressions.list(client)
      {:ok, suppressions} = Unsent.Suppressions.list(client, page: 2, limit: 50)
      {:ok, suppressions} = Unsent.Suppressions.list(client, reason: "HARD_BOUNCE")
      {:ok, suppressions} = Unsent.Suppressions.list(client, search: "example.com")
  """
  @spec list(Client.t(), keyword()) :: {:ok, list(map())} | {:error, any()}
  def list(client, query \\ []) do
    params = build_query_params(query, [:page, :limit, :search, :reason])
    path = build_path("/suppressions", params)
    Client.get(client, path)
  end

  @doc """
  Add an email to the suppression list.

  ## Parameters

    * `payload` - Map containing suppression details

  ## Examples

      {:ok, suppression} = Unsent.Suppressions.add(client, %{
        email: "user@example.com",
        reason: "MANUAL"
      })
  """
  @spec add(Client.t(), Types.AddSuppressionRequest.t() | map()) :: {:ok, Types.AddSuppression200Response.t()} | {:error, any()}
  def add(client, payload) do
    Client.post(client, "/suppressions", payload)
  end

  @doc """
  Remove an email from the suppression list.

  ## Parameters

    * `email` - The email address to remove from suppression list

  ## Examples

      {:ok, _} = Unsent.Suppressions.delete(client, "user@example.com")
  """
  @spec delete(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, email) do
    Client.delete(client, "/suppressions/email/#{email}")
  end

  # Private helper functions

  defp build_query_params(query, allowed_keys) do
    query
    |> Keyword.take(allowed_keys)
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params)
    "#{base_path}?#{query_string}"
  end
end
