defmodule Chat.MixProject do
  use Mix.Project

  def project do
    [
      app: :chat,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Chat.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.16"},
      {:bandit, "~> 1.6"},
      {:websock_adapter, "~> 0.5.8"},
      {:nitro, "~> 9.9"},
      {:n2o, "~> 11.9"},
      {:syn, "~> 2.1"}
    ]
  end
end
