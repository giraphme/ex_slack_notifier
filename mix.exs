defmodule ExSlackNotifier.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_slack_notifier,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.1"},
      {:slack, "~> 0.15"},
      {:power_assert, "~> 0.1.1", only: :test, optional: true},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false, optional: true},
      {:dialyxir, "~> 1.0.0-rc.3", only: :dev, runtime: false, optional: true},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false, optional: true}
    ]
  end
end
