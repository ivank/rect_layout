defmodule RectLayout.MixProject do
  use Mix.Project

  def project do
    [
      app: :rect_layout,
      version: "0.2.0",
      elixir: "~> 1.15",
      description: description(),
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/ivank/rect_layout",
      deps: deps(),
      docs: docs(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.json": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp description() do
    """
    Create and manipulate rectangular objects and groups of objects.
    This is meant to allow generating dynamic svgs easier as it allows you to calculate positions of various svg elements with relation to each other.
    """
  end

  def docs do
    [
      main: "readme",
      extras: ["README.md", "LICENSE.md"],
      groups_for_docs: [
        Constructor: &(&1[:section] == :constructor),
        Transform: &(&1[:section] == :transform),
        Accessor: &(&1[:section] == :accessor)
      ]
    ]
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/ivank/rect_layout"}
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
      {:ex_doc, "~> 0.18", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test}
    ]
  end
end
