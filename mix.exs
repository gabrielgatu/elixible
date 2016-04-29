defmodule Elixible.Mixfile do
  use Mix.Project

  def project do
    [app: :elixible,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: {Elixible, []},
      applications: [:logger]
    ]
  end

  # Dependencies can be Hex packages:
  defp deps do
    []
  end
end
