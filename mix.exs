defmodule GenStageMeetup.Mixfile do
  use Mix.Project

  def project do
    [app: :gen_stage_meetup,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:gen_stage, "~> 0.6.1"}]
  end

  defp aliases do
    ["test": ["test --exclude skip"]]
  end
end
