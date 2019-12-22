defmodule RTypesPropCheck.MixProject do
  use Mix.Project

  def project do
    [
      app: :rtypes_propcheck,
      version: "0.1.0",
      elixir: "~> 1.8",
      description: "Automatically derive PropCheck data generators for use with RTypes library",
      name: "rtypes_propcheck",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  def elixirc_paths(:prod) do
    ["lib"]
  end

  def elixirc_paths(:dev) do
    ["lib"]
  end

  def elixirc_paths(:test) do
    ["lib", "test/lib"]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rtypes, "~> 0.3.0"},
      {:propcheck, "~> 1.2"}
    ]
  end
end
