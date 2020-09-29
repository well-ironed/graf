defmodule ModuleCCallsB.MixProject do
  use Mix.Project

  def project do
    [
      app: :module_c_calls_b,
      version: "0.1.0",
      elixir: "~> 1.8",
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
      {:module_a_calls_b, path: "../module_a_calls_b"}
    ]
  end
end
