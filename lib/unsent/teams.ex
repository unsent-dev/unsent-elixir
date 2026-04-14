# @manual
defmodule Unsent.Teams do
  @moduledoc """
  Client for team operations.
  """

  alias Unsent.Client

  @doc """
  Get current team information.

  ## Examples

      {:ok, team} = Unsent.Teams.get(client)
  """
  def get(client) do
    Client.get(client, "/team")
  end

  @doc """
  List all teams.

  ## Examples

      {:ok, teams} = Unsent.Teams.list(client)
  """
  def list(client) do
    Client.get(client, "/teams")
  end
end
