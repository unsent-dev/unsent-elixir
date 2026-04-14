# @manual
defmodule Unsent.Webhooks do
  @moduledoc """
  Client for webhook operations.

  > #### Future Feature {: .warning}
  >
  > This resource is currently in development and not fully implemented on the server side yet.
  > The methods below are placeholders/preparations for the future implementation.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  List all webhooks.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, webhooks} = Unsent.Webhooks.list(client)
  """
  @spec list(Client.t()) :: {:ok, list(Types.Webhook.t())} | {:error, any()}
  def list(client) do
    Client.get(client, "/webhooks")
  end

  @doc """
  Create a new webhook.

  **Note**: This is a placeholder for a future feature.

  ## Parameters

    * `payload` - Map containing:
      * `:url` - Webhook URL endpoint
      * `:eventTypes` - List of event types to subscribe to

  ## Examples

      {:ok, webhook} = Unsent.Webhooks.create(client, %{
        url: "https://example.com/webhooks",
        eventTypes: ["email.sent", "email.delivered", "email.bounced"]
      })
  """
  @spec create(Client.t(), Types.CreateWebhookRequest.t() | map()) :: {:ok, Types.Webhook.t()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/webhooks", payload)
  end

  @doc """
  Update a webhook.

  **Note**: This is a placeholder for a future feature.

  ## Parameters

    * `id` - Webhook ID
    * `payload` - Map containing fields to update (`:url`, `:eventTypes`)

  ## Examples

      {:ok, webhook} = Unsent.Webhooks.update(client, "webhook_123", %{
        eventTypes: ["email.sent", "email.delivered"]
      })
  """
  @spec update(Client.t(), String.t(), Types.UpdateWebhookRequest.t() | map()) :: {:ok, Types.Webhook.t()} | {:error, any()}
  def update(client, id, payload) do
    Client.patch(client, "/webhooks/#{id}", payload)
  end

  @doc """
  Delete a webhook by ID.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, _} = Unsent.Webhooks.delete(client, "webhook_123")
  """
  @spec delete(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, id) do
    Client.delete(client, "/webhooks/#{id}")
  end

  @doc """
  Get a specific webhook by ID.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, webhook} = Unsent.Webhooks.get(client, "webhook_123")
  """
  @spec get(Client.t(), String.t()) :: {:ok, Types.Webhook.t()} | {:error, any()}
  def get(client, id) do
    Client.get(client, "/webhooks/#{id}")
  end

  @doc """
  Test a webhook by sending a test payload.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, result} = Unsent.Webhooks.test(client, "webhook_123")
  """
  @spec test(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def test(client, id) do
    Client.post(client, "/webhooks/#{id}/test", %{})
  end
end
