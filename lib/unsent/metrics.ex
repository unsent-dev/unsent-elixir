# @manual
defmodule Unsent.Metrics do
  @moduledoc """
  Client for performance metrics operations.
  """

  alias Unsent.Client

  @doc """
  Retrieve performance metrics.

  ## Parameters

    * `query` - Optional query parameters:
      * `:period` - Time period ("day", "week", "month", default: "month")

  ## Examples

      {:ok, metrics} = Unsent.Metrics.get(client)
      {:ok, metrics} = Unsent.Metrics.get(client, period: "week")
  """
  @spec get(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def get(client, query \\ []) do
    params = build_query_params(query)
    path = build_path("/metrics", params)
    Client.get(client, path)
  end

  # Private helpers

  defp build_query_params(query) do
    query
    |> Keyword.take([:period])
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
