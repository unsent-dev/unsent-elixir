# @manual
defmodule Unsent.Contacts do
  @moduledoc """
  Client for contact operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  List contacts in a contact book.

  ## Parameters

    * `contact_book_id` - The ID of the contact book
    * `query` - Optional query parameters:
      * `:emails` - Filter by email addresses (comma-separated)
      * `:page` - Page number for pagination
      * `:limit` - Number of items per page
      * `:ids` - Filter by contact IDs (comma-separated)

  ## Examples

      {:ok, contacts} = Unsent.Contacts.list(client, "book_123")
      {:ok, contacts} = Unsent.Contacts.list(client, "book_123", page: 2, limit: 50)
      {:ok, contacts} = Unsent.Contacts.list(client, "book_123", emails: "user1@example.com,user2@example.com")
  """
  @spec list(Client.t(), String.t(), keyword()) :: {:ok, list(map())} | {:error, any()}
  def list(client, contact_book_id, query \\ []) do
    params = build_query_params(query, [:emails, :page, :limit, :ids])
    path = build_path("/contactBooks/#{contact_book_id}/contacts", params)
    Client.get(client, path)
  end

  @spec create(Client.t(), String.t(), Types.CreateContactRequest.t() | map()) :: {:ok, Types.CreateContact200Response.t()} | {:error, any()}
  def create(client, book_id, payload) do
    Client.post(client, "/contactBooks/#{book_id}/contacts", payload)
  end

  @spec get(Client.t(), String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get(client, book_id, contact_id) do
    Client.get(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
  end

  @spec update(Client.t(), String.t(), String.t(), Types.UpdateContactRequest.t() | map()) :: {:ok, map()} | {:error, any()}
  def update(client, book_id, contact_id, payload) do
    Client.patch(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  @spec upsert(Client.t(), String.t(), String.t(), map()) :: {:ok, map()} | {:error, any()}
  def upsert(client, book_id, contact_id, payload) do
    Client.put(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  @spec delete(Client.t(), String.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, book_id, contact_id) do
    Client.delete(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
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
