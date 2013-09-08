defmodule ExCoveralls.Mixfile do
  use Mix.Project

  def project do
    [ app: :excoveralls,
      version: "0.0.1",
      elixir: "~> 0.10.3-dev",
      deps: deps,
    ] ++ excoveralls_setting
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      {:json, github: "cblage/elixir-json"},
      {:mock, ">= 0.0.3", github: "parroty/mock"},
      {:exprintf, github: "parroty/exprintf"}
    ]
  end

  # Settings for excoveralls
  defp excoveralls_setting do
    [
      test_coverage: [tool: ExCoveralls, type: "local"],
      env: [
        coveralls_travis:  [test_coverage: [tool: ExCoveralls, type: "travis"]],
        coveralls_local:   [test_coverage: [tool: ExCoveralls, type: "local"]],
        coveralls_general: [test_coverage: [tool: ExCoveralls, type: "general"]]
      ]
    ]
  end
end
