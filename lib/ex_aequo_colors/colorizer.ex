defmodule ExAequoColors.Colorizer do
  use ExAequoBase.Types

  alias ExAequoColors.Color
  alias ExAequoBase.RegexParser, as: Parser
  import ExAequoBase.Enum, only: [map_ok: 2]
  import ExAequoBase.Fn, only: [select: 1]
  import ExAequoBase.Text, only: [behead: 2, parse_up_to: 3]
  import ExAequoColors.Color, only: [color: 2]

  @moduledoc ~S"""
  Backend of the cli
  """

  @type color_t :: maybe(result_t(binary()))
  @type color_fn_t :: (-> color_t())

  @default_options %{
    trigger: "<",
    closer: ">",
    resetter: "$"
  }

  @doc ~S"""
  colorizes a binary according to options

      iex(1)> colorize("hello")
      {:ok, "hello"}

  # Default Options, resetting with `$`

  Here are the default options, a color is triggered by `<...`

      iex(2)> colorize("<green>")
      {:ok, "\e[32m"}

  We can also add bold for example

      iex(3)> colorize("<green, bold>success")
      {:ok, "\e[32m\e[1msuccess"}

  And resetting is simply achieved by a `$`

      iex(4)> colorize("$")
      {:ok, "\e[0m"}

  Which works in both orders, and note that the space after the `,` is not needed, we use 
  `$` to reset here!

      iex(5)> colorize("<bold,yellow>highlighted$normal")
      {:ok, "\e[1m\e[33mhighlighted\e[0mnormal"}

  We can use other color systems, like ANSI 256, also demonstrating how to escape `<` and `$`:

      iex(6)> colorize("256<color21><<$$")
      {:ok, "256\e[38;5;21m<$"}

  Dim, italic and named RGB colors are also at your disposal

      iex(7)> colorize("<dim, light_coral>and<italic>")
      {:ok, "\e[2m\e[38;2;255;135;135mand\e[3m"}

  # Using different options

  Maybe we want to open and close color definitions with the `!` character, note also that,
  in that case we need to double the `!` character, but not the `<` character anymore, to
  get them as verbatim text

      iex(8)> colorize("!red!!!<$", trigger: "!", closer: "!")
      {:ok, "\e[31m!<\e[0m"}

  """

  @spec colorize(binary()) :: color_t()
  def colorize(line), do: colorize(line, [])

  @spec colorize(binary() | binaries(), map()) :: color_t()
  def colorize(line_or_lines, options)

  def colorize(line, options) when is_binary(line) do
    colorize([line], options)
  end

  def colorize(lines, options) do
    with {options, regexen} <- mk_options_and_rgxen(options) do
      result =
        lines
        |> Enum.map(&parse(regexen, &1))
        |> Enum.join(options.reset <> "\n")

      {:ok, result <> options.reset}
    end
  end

  def colorize!(line, {options, regexen}) do
    parse(regexen, line) <> options.reset
  end

  @doc false
  def mk_options_and_rgxen(options) do
    options = options |> Enum.into(@default_options)
    reset = if Map.get(options, :auto), do: color("", :reset), else: ""
    {Map.put(options, :reset, reset), _compile_regexen(options)}
  end

  @doc false
  def parse(regexen, line) do
    regexen
    |> Parser.parse(line) 
    |> IO.chardata_to_string
  end

  @spec _compile_regexen(map()) :: list(Regex.t())
  defp _compile_regexen(options) do
    [
      _compile_double_escape(options, :trigger),
      _compile_double_escape(options, :resetter),
      _compile_trigger(options.trigger, options.closer),
      _compile_reset(options),
      _compile_verb(options)
    ]
  end

  @splitter_rgx ~r/,\s*/
  defp _compile_color_spec(color_spec) do
    specs = String.split(color_spec, @splitter_rgx)
    codes = specs |> Enum.map(&String.to_atom/1)
    Color.color("", codes)
  end

  @spec _compile_double_escape(map(), atom()) :: Regex.t()
  defp _compile_double_escape(options, key) do
    # IO.inspect(options)
    trigger = Map.get(options, key) |> String.at(0)
    trigger_rgx = Regex.escape(trigger)
    rgx = Regex.compile!("\\A(#{trigger_rgx})#{trigger_rgx}")
    {rgx, trigger}
  end

  @spec _compile_reset(map()) :: Regex.t()
  defp _compile_reset(options) do
    resetter = options.resetter
    {Regex.compile!("\\A(#{Regex.escape(resetter)})"), Color.color("", [:reset])}
  end

  defp _compile_trigger(open, close) do
    {
      Regex.compile!("\\A#{Regex.escape(open)}(.*?)#{Regex.escape(close)}(.*)"),
      &_compile_color_spec/1
    }
  end

  @spec _compile_verb(map()) :: Regex.t()
  defp _compile_verb(options) do
    excluded = String.at(options.trigger, 0) <> String.at(options.resetter, 0)
    rgx = Regex.compile!("\\A([^#{excluded}]+)(.*)")
    {rgx}
  end

  #   @spec _parse(binary(), list(), map()) :: color_t()
  #   defp _parse(line, result, options)
  #   defp _parse("", result, _) do
  #     {:ok, IO.chardata_to_string(result)}
  #   end
  #   defp _parse(input, result, options) do
  #     select([
  #       _parse_escaped_trigger_fn(input, result, options),
  #       _parse_escaped_resetter_fn(input, result, options),
  #       _parse_verbatim_fn(input, result, options),
  #     ])
  #   end

  #   @spec _parse_escaped(binary(), list(), map(), binary()) :: color_t()
  #   defp _parse_escaped(input, result, options, toescape) do
  #     first_trigger = String.at(toescape, 0)
  #     escaped_trigger = first_trigger <> first_trigger
  #     if String.starts_with?(input, escaped_trigger) do
  #       _parse(behead(input, 2), [result, first_trigger], options)
  #     end
  #   end

  #   @spec _parse_escaped_resetter_fn(binary(), list(), map()) :: color_fn_t()
  #   defp _parse_escaped_resetter_fn(input, result, options) do
  #     fn ->
  #       case Map.get(options, :resetter) do
  #         nil -> nil 
  #         resetter -> _parse_escaped(input, result, options, resetter)
  #       end
  #     end
  #   end

  #   @spec _parse_escaped_trigger_fn(binary(), list(), map()) :: color_fn_t() 
  #   defp _parse_escaped_trigger_fn(input, result, options) do
  #     fn -> 
  #       _parse_escaped(input, result, options, options.trigger)
  #     end
  #   end

  #   @spec _parse_verbatim(binary(), list(), map()) :: color_t()
  #   defp _parse_verbatim(input, result, options) do
  #     case parse_up_to(input, options.non_verb, :keep) do

  #     end

  #   end

  #   @spec _parse_verbatim_fn(binary(), list(), map()) :: color_fn_t()
  #   defp _parse_verbatim_fn(input, result, options) do
  #     fn ->
  #       _parse_verbatim(input, result, options)
  #     end
  #   end
  # defp _colorize_line({line, lnb}, auto) do
  #   case line |>_parse(auto, []) do
  #     {:ok, result} -> {:ok, IO.chardata_to_string(result)}
  #     error -> error
  #   end
  # end

  # defp _extract_flag(args, flags) do
  #   Enum.any?(flags, &Enum.member?(args, &1))
  # end

  # @verb ~r/(.+?)([$<].*)/
  # defp _parse(line, auto, result)
  # defp _parse("\n", auto, result) do
  #   if auto do
  #     [result, color_code(:reset)]
  #   else
  #     result
  #   end
  # end
  # defp _parse("", auto, result) do
  #   if auto do
  #     [result, color_code(:reset)]
  #   else
  #     result
  #   end
  # end
  # defp _parse("$$" <> rest, auto, result) do
  #   _parse(rest, auto, [result, "$"])
  # end
  # defp _parse("$" <> rest, auto, result) do
  #   _parse(rest, auto, [result, color_code(:reset)])
  # end
  # defp _parse("<<" <> rest, auto, result) do
  #   _parse(rest, auto, [result, "<"])
  # end
  # defp _parse("<" <> rest, auto, result) do
  #   _parse_color(rest, auto, result)
  # end
  # defp _parse(input, auto, result) do
  #   case Regex.run(@verb, input) do
  #     [_, verb, rest] -> _parse(rest, auto, [result, verb])
  #   end
  # end

  # @color ~r/\A (.*?) > (.*) \z/
  # defp _parse_color(input, auto, result) do
  #   # case Regex.run(@color, input) do

  #   # end
  # end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
