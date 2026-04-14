# @manual
defmodule Unsent.Activity do
  @moduledoc """
  Client for activity feed operations.
  """

  alias Unsent.Client

  @doc """
  Retrieve activity feed with email events and details.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 50, max: 100)

  ## Examples

      {:ok, activity} = Unsent.Activity.get(client)
      {:ok, activity} = Unsent.Activity.get(client, page: 2, limit: 20)
  """
  @spec get(Client.t(), keyword()) :: {:ok, map() | nil} | {:error, any()}
  def get(client, query \\ []) do
    params = build_query_params(query)
    path = build_path("/activity", params)
    Client.get(client, path)
  end

  # Private helpers

  defp build_query_params(query) do
    query
    |> Keyword.take([:page, :limit])
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
