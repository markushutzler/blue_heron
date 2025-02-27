defmodule BlueHeron.MixProject do
  use Mix.Project

  @version "0.3.0"
  @source_url "https://github.com/blue-heron/blue_heron"

  def project do
    [
      app: :blue_heron,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      dialyzer: dialyzer(),
      docs: docs(),
      package: package(),
      preferred_cli_env: [
        credo: :test,
        docs: :docs,
        "hex.build": :docs,
        "hex.publish": :docs
      ]
    ]
  end

  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.25", only: :docs, runtime: false},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.5", only: :test, runtime: false}
    ]
  end

  defp description() do
    "Use Bluetooth LE in Elixir"
  end

  defp dialyzer() do
    [
      flags: [:race_conditions, :unmatched_returns, :error_handling, :underspecs],
      plt_add_apps: [:mix]
    ]
  end

  defp docs() do
    [
      extras: [
        "README.md",
        "CHANGELOG.md",
        NOTICE: [title: "Notice"],
        LICENSE: [title: "License"]
      ],
      groups_for_modules: [
        ATT: [~r/^BlueHeron\.ATT($|\.)/],
        # NOTE: These need to be listed out manually because otherwise they'll
        # catch `BlueHeron.HCI.Command` and `BlueHeron.HCI.Event`
        HCI: [
          BlueHeron.HCI,
          BlueHeron.HCI.ArrayedData,
          BlueHeron.HCI.CommandComplete.ReturnParameters,
          BlueHeron.HCI.Deserializable,
          BlueHeron.HCI.Serializable,
          BlueHeron.HCI.Transport,
          BlueHeron.HCI.Transport.NULL,
          BlueHeron.HCIDump,
          BlueHeron.HCIDump.Logger,
          BlueHeron.HCIDump.PKTLOG
        ],
        "HCI Commands": [~r/^BlueHeron\.HCI.Command($|\.)/],
        "HCI Events": [~r/^BlueHeron\.HCI.Event($|\.)/]
      ],
      nest_modules_by_prefix: [
        BlueHeron.ATT,
        BlueHeron.HCI.Command,
        BlueHeron.HCI.Event
      ],
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
    ]
  end

  defp package() do
    [
      files: [
        "lib",
        "test",
        "mix.exs",
        "README.md",
        "LICENSE",
        "NOTICE",
        "CHANGELOG.md"
      ],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end
end
