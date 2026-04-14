# @manual
defmodule Unsent.Stats do
  @moduledoc """
  Client for statistics operations.
  """

  alias Unsent.Client

  @doc """
  Retrieve email statistics.

  ## Parameters

    * `query` - Optional query parameters:
      * `:startDate` - Filter by start date (ISO 8601 format)
      * `:endDate` - Filter by end date (ISO 8601 format)

  ## Examples

      {:ok, stats} = Unsent.Stats.get(client)
      {:ok, stats} = Unsent.Stats.get(client, startDate: "2024-01-01T00:00:00Z")
      {:ok, stats} = Unsent.Stats.get(client, startDate: "2024-01-01", endDate: "2024-01-31")
  """
  @spec get(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def get(client, query \\ []) do
    params = build_query_params(query)
    path = build_path("/stats", params)
    Client.get(client, path)
  end

  # Private helpers

  defp build_query_params(query) do
    query
    |> Keyword.take([:startDate, :endDate])
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
