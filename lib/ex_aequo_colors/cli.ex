defmodule ExAequoColors.Cli do

  # import ExAequoBase.Map, only: [put_if: 3]
  import ExAequoColors.Color, only: [color: 2]
  # import ExAequoColors.Colorizer, only: [colorize: 2, colorize!: 3]
  import ExAequoColors.Colorizer, only: [colorize!: 3, make_parser: 1]

  @moduledoc false

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
    -t|--trigger String that triggers a color code, (first char of trigger needs to be doubled to get a verbatim trigger). Defaults to "<"

  """
    # --html       Short for --trigger <!-- and --closer -->    


    def main(args) do
      case parse_args(args) do
        [x] ->  
          IO.puts(:stderr, color("ERROR:", [:bold, :red, :reset]) <> inspect(x))
          IO.puts(:stderr, @args)
        :help -> IO.puts(@args)
        :version -> IO.puts("colorize v#{_version()}")
        options -> options
      # |> _add_defaults()
      # |> _add_shortcuts()
      |> colorize_input() 
      |> IO.puts 
      end
    end

    defp colorize_input(options) do
      case Map.get(options, :file) do
        nil -> IO.stream(:stdio, :line)
        file -> File.stream!(file, :line)
      end 
      |> run(options) 
    end


    defp run(stream, options) do
      parser = make_parser(options)
      stream
      |> Stream.with_index
      |> Stream.map(&colorize_line(&1, parser, options))
      |> Enum.join("\n") 
    end

    defp colorize_line({line, index}, parser, options) do
      case colorize!(line, parser, options) do
        {:ok, ast} -> ast
        {:error, reason} -> raise "#{reason} in line #{index + 1}"
      end
    end
  # defp _add_defaults(options) do
  #   options
  #   |> Map.put_new(:trigger, "<") 
  #   |> Map.put_new(:closer, ">") 
  # end

  # defp _add_shortcuts(options) do
  #   options
  #   |> put_if(options.html, [trigger: "<!--", closer: "-->"]) 
  #   |> put_if(options.dollar, [resetter: "$"])
  # end

  # defp _colorize_line({line, lnb}, options) do
  #   case colorize(line, options) do
  #     {:ok, result} -> result
  #     {:error, message} -> raise "Error in line #{lnb}: #{message}"
  #   end
  # end

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
      version: :boolean,
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
      {_, _, [_ | _] = errors} -> errors
      {[{:help, true}], _, _} -> :help
      {[{:version, true}], _, _} -> :version
      {options, [file], _} -> options |> Enum.into(%{}) |> Map.put(:file, file) |> Map.put(:no_color, System.get_env("NO_COLOR", Keyword.get(options, :no_color)))
      {options, [], _} -> options |> Enum.into(%{}) |> Map.put(:no_color, System.get_env("NO_COLOR", Keyword.get(options, :no_color)))
    end
  end

    # defp put_if(map, key, pairs) do
    #   if Map.get(map, key) do
    #     pairs
    #     |> Enum.inject(map, fn {k, v}, a -> Map.put(a, k, v) end) 
    #   else
    #     map
    #   end
    # end
    @spec _version() :: binary()
    defp _version do
      with {:ok, version} <- :application.get_key(:ex_aequo_colors, :vsn),
           do: to_string(version)
      end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
