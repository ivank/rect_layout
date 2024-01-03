defmodule RectLayout.MixProject do
  use Mix.Project

  def project do
    [
      app: :rect_layout,
      version: "0.1.0",
      elixir: "~> 1.15",
      description: description(),
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/ivank/rect_layout",
      deps: deps(),
      docs: docs(),
      package: package()
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
      extras: ["README.md", "LICENSE.md"]
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
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
