# @manual
defmodule Unsent.Campaigns do
  @moduledoc """
  Client for campaign operations.
  """

  alias Unsent.Client
  alias Unsent.Types

  @doc """
  Retrieve all campaigns.

  ## Examples

      {:ok, campaigns} = Unsent.Campaigns.list(client)
  """
  @spec list(Client.t()) :: {:ok, list(Types.GetCampaigns200ResponseInner.t())} | {:error, any()}
  def list(client) do
    Client.get(client, "/campaigns")
  end

  @spec create(Client.t(), Types.CreateCampaignRequest.t() | map()) :: {:ok, Types.CreateCampaign200Response.t()} | {:error, any()}
  def create(client, payload) do
    Client.post(client, "/campaigns", payload)
  end

  @spec get(Client.t(), String.t()) :: {:ok, Types.CreateCampaign200Response.t()} | {:error, any()}
  def get(client, campaign_id) do
    Client.get(client, "/campaigns/#{campaign_id}")
  end

  @spec schedule(Client.t(), String.t(), Types.ScheduleCampaignRequest.t() | map()) :: {:ok, map()} | {:error, any()}
  def schedule(client, campaign_id, payload) do
    Client.post(client, "/campaigns/#{campaign_id}/schedule", payload)
  end

  @spec pause(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def pause(client, campaign_id) do
    Client.post(client, "/campaigns/#{campaign_id}/pause", %{})
  end

  @spec resume(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def resume(client, campaign_id) do
    Client.post(client, "/campaigns/#{campaign_id}/resume", %{})
  end

  @doc """
  Delete a campaign.

  ## Examples

      {:ok, result} = Unsent.Campaigns.delete(client, "campaign_id")
  """
  @spec delete(Client.t(), String.t()) :: {:ok, map()} | {:error, any()}
  def delete(client, campaign_id) do
    Client.delete(client, "/campaigns/#{campaign_id}")
  end
end
