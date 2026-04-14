# @manual
defmodule Unsent.Domains do
  @moduledoc """
  Client for domain operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @spec list(Client.t()) :: {:ok, list(Types.GetDomains200ResponseInner.t())} | {:error, any()}
  def list(client) do
    Client.get(client, "/domains")
  end

  @spec create(Client.t(), Types.CreateDomainRequest.t() | map()) :: {:ok, Types.GetDomains200ResponseInner.t()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/domains", payload)
  end

  @spec verify(Client.t(), String.t()) :: {:ok, Types.GetDomains200ResponseInner.t()} | {:error, any()}
  def verify(client, domain_id) do
    Client.put(client, "/domains/#{domain_id}/verify", %{})
  end

  @spec get(Client.t(), String.t()) :: {:ok, Types.GetDomains200ResponseInner.t()} | {:error, any()}
  def get(client, domain_id) do
    Client.get(client, "/domains/#{domain_id}")
  end

  @spec delete(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, domain_id) do
    Client.delete(client, "/domains/#{domain_id}")
  end

  @doc """
  Get analytics for a specific domain.

  ## Parameters

    * `domain_id` - The ID of the domain
    * `query` - Optional query parameters:
      * `:period` - Time period ("day", "week", "month", default: "month")

  ## Examples

      {:ok, analytics} = Unsent.Domains.get_analytics(client, "domain_123")
      {:ok, analytics} = Unsent.Domains.get_analytics(client, "domain_123", period: "week")
  """
  @spec get_analytics(Client.t(), String.t(), keyword()) :: {:ok, list(Types.GetDomainAnalytics200ResponseInner.t())} | {:error, any()}
  def get_analytics(client, domain_id, query \\ []) do
    params = build_query_params(query, [:period])
    path = build_path("/domains/#{domain_id}/analytics", params)
    Client.get(client, path)
  end

  @doc """
  Get statistics for a specific domain.

  ## Parameters

    * `domain_id` - The ID of the domain
    * `query` - Optional query parameters:
      * `:startDate` - Filter by start date (ISO 8601 format)
      * `:endDate` - Filter by end date (ISO 8601 format)

  ## Examples

      {:ok, stats} = Unsent.Domains.get_stats(client, "domain_123")
      {:ok, stats} = Unsent.Domains.get_stats(client, "domain_123", startDate: "2024-01-01")
  """
  @spec get_stats(Client.t(), String.t(), keyword()) :: {:ok, Types.GetDomainStats200Response.t()} | {:error, any()}
  def get_stats(client, domain_id, query \\ []) do
    params = build_query_params(query, [:startDate, :endDate])
    path = build_path("/domains/#{domain_id}/stats", params)
    Client.get(client, path)
  end

  @doc """
  List all routes for a domain.

  ## Parameters

    * `id` - The ID of the domain

  ## Examples

      {:ok, routes} = Unsent.Domains.list_routes(client, "domain_123")
  """
  @spec list_routes(Client.t(), String.t()) :: {:ok, list(map())} | {:error, any()}
  def list_routes(client, id) do
    Client.get(client, "/domains/#{id}/routes")
  end

  @doc """
  Add a route to a domain.

  ## Parameters

    * `id` - The ID of the domain
    * `payload` - Route data:
      * `:providerConnectionId` - Provider connection ID (required)
      * `:weight` - Route weight (optional)

  ## Examples

      {:ok, route} = Unsent.Domains.add_route(client, "domain_123", %{providerConnectionId: "conn_456"})
  """
  @spec add_route(Client.t(), String.t(), map()) :: {:ok, map()} | {:error, any()}
  def add_route(client, id, payload) do
    Client.post(client, "/domains/#{id}/routes", payload)
  end

  @doc """
  Update a domain route.

  ## Parameters

    * `id` - The ID of the domain
    * `route_id` - The ID of the route
    * `payload` - Route data:
      * `:weight` - Route weight (optional)
      * `:clickTracking` - Enable click tracking (optional)
      * `:openTracking` - Enable open tracking (optional)

  ## Examples

      {:ok, result} = Unsent.Domains.update_route(client, "domain_123", "route_456", %{weight: 50})
  """
  @spec update_route(Client.t(), String.t(), String.t(), map()) :: {:ok, map()} | {:error, any()}
  def update_route(client, id, route_id, payload) do
    Client.patch(client, "/domains/#{id}/routes/#{route_id}", payload)
  end

  @doc """
  Delete a domain route.

  ## Parameters

    * `id` - The ID of the domain
    * `route_id` - The ID of the route

  ## Examples

      {:ok, result} = Unsent.Domains.delete_route(client, "domain_123", "route_456")
  """
  @spec delete_route(Client.t(), String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete_route(client, id, route_id) do
    Client.delete(client, "/domains/#{id}/routes/#{route_id}")
  end

  # Private helpers

  defp build_query_params(query, allowed_keys) do
    query
    |> Keyword.take(allowed_keys)
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
