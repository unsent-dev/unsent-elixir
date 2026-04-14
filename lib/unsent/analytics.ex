# @manual
defmodule Unsent.Analytics do
  @moduledoc """
  Client for analytics operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Retrieve email analytics.

  ## Examples

      {:ok, analytics} = Unsent.Analytics.get(client)
  """
  @spec get(Client.t()) :: {:ok, Types.GetAnalytics200Response.t()} | {:error, any()}
  def get(client) do
    Client.get(client, "/analytics")
  end

  @doc """
  Retrieve analytics data over time.

  ## Parameters

    * `query` - Optional query parameters:
      * `:days` - Number of days to retrieve data for
      * `:domain` - Filter by specific domain

  ## Examples

      {:ok, data} = Unsent.Analytics.get_time_series(client, days: 30)
      {:ok, data} = Unsent.Analytics.get_time_series(client, days: 7, domain: "example.com")
  """
  @spec get_time_series(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def get_time_series(client, query \\ []) do
    params = build_query_params(query, [:days, :domain])
    path = build_path("/analytics/time-series", params)
    Client.get(client, path)
  end

  @doc """
  Retrieve sender reputation score.

  ## Parameters

    * `query` - Optional query parameters:
      * `:domain` - Filter by specific domain

  ## Examples

      {:ok, reputation} = Unsent.Analytics.get_reputation(client)
      {:ok, reputation} = Unsent.Analytics.get_reputation(client, domain: "example.com")
  """
  @spec get_reputation(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def get_reputation(client, query \\ []) do
    params = build_query_params(query, [:domain])
    path = build_path("/analytics/reputation", params)
    Client.get(client, path)
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
