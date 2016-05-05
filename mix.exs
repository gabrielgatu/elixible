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
      applications: [:logger, :fast_xml, :stringprep]
    ]
  end

  # Dependencies can be Hex packages:
  defp deps do
    [
      {:fast_xml, "~> 1.1"},
      {:stringprep, "~> 1.0"}
    ]
  end
end
