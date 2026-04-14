defmodule Unsent.MixProject do
  use Mix.Project

  def project do
    [
      app: :unsent,
      version: "1.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: "Official Elixir SDK for the Unsent API - Send transactional emails with ease",
      package: package(),
      deps: deps(),
      name: "Unsent",
      source_url: "https://github.com/unsent-dev/unsent-elixir"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:mox, "~> 1.0", only: :test},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/unsent-dev/unsent-elixir"}
    ]
  end
end
