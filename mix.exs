defmodule ExSeeClickFix.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_see_click_fix,
      version: "0.1.3",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:etso, "~> 0.1.2"},
      {:external_service, "~> 1.0.1"},
      {:hackney, ">= 1.9.0"},
      {:jason, ">= 1.0.0"},
      {:tesla, "~> 1.0"}
    ]
  end
end
