# @manual
defmodule Unsent.Templates do
  @moduledoc """
  Client for email template operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Retrieve all email templates.

  ## Examples

      {:ok, templates} = Unsent.Templates.list(client)
  """
  @spec list(Client.t()) :: {:ok, Types.GetTemplates200Response.t()} | {:error, any()}
  def list(client) do
    Client.get(client, "/templates")
  end

  @doc """
  Create a new email template.

  ## Parameters

    * `payload` - Map containing template details

  ## Examples

      {:ok, template} = Unsent.Templates.create(client, %{
        name: "Welcome Email",
        subject: "Welcome {{name}}!",
        html: "<h1>Welcome {{name}}</h1>"
      })
  """
  @spec create(Client.t(), Types.CreateTemplateRequest.t() | map()) :: {:ok, Types.CreateTemplate200Response.t()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/templates", payload)
  end

  @doc """
  Get a specific template by ID.

  ## Examples

      {:ok, template} = Unsent.Templates.get(client, "template_123")
  """
  @spec get(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def get(client, id) do
    Client.get(client, "/templates/#{id}")
  end

  @doc """
  Update an email template.

  ## Parameters

    * `id` - Template ID
    * `payload` - Map containing fields to update

  ## Examples

      {:ok, template} = Unsent.Templates.update(client, "template_123", %{
        subject: "Updated Welcome {{name}}!"
      })
  """
  @spec update(Client.t(), String.t(), Types.UpdateTemplateRequest.t() | map()) :: {:ok, map()} | {:error, any()}
  def update(client, id, payload) do
    Client.patch(client, "/templates/#{id}", payload)
  end

  @doc """
  Delete a template by ID.

  ## Examples

      {:ok, _} = Unsent.Templates.delete(client, "template_123")
  """
  @spec delete(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, id) do
    Client.delete(client, "/templates/#{id}")
  end
end
