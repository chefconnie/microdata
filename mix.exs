defmodule Microdata.MixProject do
  use Mix.Project

  def project do
    [
      app: :microdata,
      version: "0.1.3",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: description(),
      package: package(),

      # HexDocs
      name: "Microdata",
      source_url: "https://github.com/chefconnie/microdata",
      docs: [main: "Microdata"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:httpoison, "~> 1.0", optional: true},
      {:meeseeks, "~> 0.10.0"}
    ]
  end

  defp description do
    "Microdata is an Elixir library for parsing microdata from a provided document. Includes helper functions, eg for looking up typed items in a document, and named properties in an item."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{Github: "https://github.com/chefconnie/microdata"},
      maintainers: ["anulman"]
    ]
  end
end
