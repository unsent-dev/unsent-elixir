# @manual
defmodule Unsent.Events do
  @moduledoc """
  Client for email event operations.
  """

  alias Unsent.Client

  @doc """
  List all email events.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 50, max: 100)
      * `:status` - Filter by status (e.g., "SENT", "DELIVERED", "BOUNCED")
      * `:startDate` - Filter by start date (ISO 8601 format)

  ## Examples

      {:ok, events} = Unsent.Events.list(client)
      {:ok, events} = Unsent.Events.list(client, page: 2, limit: 20)
      {:ok, events} = Unsent.Events.list(client, status: "DELIVERED")
      {:ok, events} = Unsent.Events.list(client, startDate: "2024-01-01T00:00:00Z")
  """
  @spec list(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def list(client, query \\ []) do
    params = build_query_params(query)
    path = build_path("/events", params)
    Client.get(client, path)
  end

  # Private helpers

  defp build_query_params(query) do
    query
    |> Keyword.take([:page, :limit, :status, :startDate])
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
