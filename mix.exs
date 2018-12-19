defmodule ExList.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_list,
      version: ("VERSION" |> File.read! |> String.trim),
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # excoveralls
      test_coverage:      [tool: ExCoveralls],
      preferred_cli_env:  [
        coveralls:              :test,
        "coveralls.travis":     :test,
        "coveralls.circle":     :test,
        "coveralls.semaphore":  :test,
        "coveralls.post":       :test,
        "coveralls.detail":     :test,
        "coveralls.html":       :test,
      ],
      # dialyxir
      dialyzer: [
        ignore_warnings: ".dialyzer_ignore",
        plt_add_apps: [
          :mix,
          :ex_unit,
        ]
      ],
      # ex_doc
      name:         "ExList",
      source_url:   "https://github.com/timCF/ex_list",
      homepage_url: "https://github.com/timCF/ex_list",
      docs:         [main: "readme", extras: ["README.md"]],
      # hex.pm stuff
      description:  "Implementation of linked list in Elixir language",
      package: [
        licenses: ["Apache 2.0"],
        files: ["lib", "priv", "mix.exs", "README*", "VERSION*"],
        maintainers: ["Ilja Tkachuk aka timCF"],
        links: %{
          "GitHub" => "https://github.com/timCF/ex_list",
          "Author's home page" => "https://timcf.github.io/",
        }
      ]
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
      # development tools
      {:excoveralls, "~> 0.8", runtime: false},
      {:dialyxir, "~> 0.5",    runtime: false},
      {:ex_doc, "~> 0.19",     runtime: false},
      {:credo, "~> 0.9",       runtime: false},
      {:boilex, "~> 0.2",      runtime: false},
    ]
  end
end
