defmodule ExAequoColors.Cli.Implementation do
  import ExAequoColors.Color, only: [color: 2]
  import ExAequoColors.Colorizer, only: [colorize_lines: 2, colorize: 2]

  @moduledoc ~S"""
  Implements the testable parts for the CLI
  """
  @args """
  <bold>usage:

    colorize  --help
    colorize  --version

    colorize string from standard input

    where options can be any of:
    -a|--auto    Reset color at the end of each line
    -c|--closer  String that ends a color code. Defaults to ">"
    -d|--dollar   Short for `--resetter $`
    -n|--no-color Removes only the color codes but does not emit ANSI colors (can also be achieved by setting the environment variable NO_COLOR)
    -r|--resetter a short for reset, defaults to nil, so you have to use e.g. `<reset>`, but can be set to any string, e.g. `$`, which then
                  needs to be doubled to be used verbatim
    -t|--trigger String that triggers a color code, (first char of trigger needs to be doubled to get a verbatim trigger). Defaults to "<<"
  """

  def main(args) do
    case parse_args(args) do
      [x] ->
        IO.puts(:stderr, color("ERROR:", [:bold, :red, :reset]) <> inspect(x))
        IO.puts(:stderr, @args)

      :help ->
        _help()

      :version ->
        IO.puts("colorize v#{_version()}")

      options ->
        options
        |> print_colorized_input()
    end
  end

  @spec _version() :: binary()
  defp _version do
    with {:ok, version} <- :application.get_key(:ex_aequo_colors, :vsn),
         do: to_string(version)
  end

  @doc false
  defp _help do
    @args
    |> String.split("\n")
    |> colorize(reset: true)
    |> IO.puts()
  end

  defp colorize_input(options) do
    case Map.get(options, :file) do
      nil -> IO.stream(:stdio, :line)
      file -> File.stream!(file, :line)
    end
    |> colorize_lines(Map.put(options, :join, true))
  end

  defp print_colorized_input(options) do
    case colorize_input(options) do
      {:ok, output} -> IO.puts(output)
      {:error, message} -> raise message
    end
  end

  defp parse_args(argv) do
    switches = [
      auto: :boolean,
      closer: :string,
      dollar: :boolean,
      help: :boolean,
      html: :boolean,
      no_color: :boolean,
      resetter: :string,
      trigger: :string,
      version: :boolean
    ]

    aliases = [
      a: :auto,
      c: :closer,
      d: :dollar,
      h: :help,
      n: :no_color,
      r: :resetter,
      t: :trigger,
      v: :version
    ]

    case OptionParser.parse(argv, strict: switches, aliases: aliases) do
      {_, _, [_ | _] = errors} ->
        errors

      {[{:help, true}], _, _} ->
        :help

      {[{:version, true}], _, _} ->
        :version

      {options, [file], _} ->
        options
        |> Enum.into(%{})
        |> Map.put(:file, file)
        |> Map.put(:no_color, System.get_env("NO_COLOR", Keyword.get(options, :no_color)))

      {options, [], _} ->
        options
        |> Enum.into(%{})
        |> Map.put(:no_color, System.get_env("NO_COLOR", Keyword.get(options, :no_color)))
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
