defmodule ExAequoColors.Colorizer do
  use ExAequoBase.Types

  alias ExAequoColors.Color
  alias ExAequoColors.Colorizer.Parser, as: Parser

  import ExAequoBase.Map, only: [put_if: 3]

  @moduledoc ~S"""
  Backend of the cli
  """

  @type color_t :: maybe(result_t(binary()))
  @type color_fn_t :: (-> color_t())

  @default_options %{
    trigger: "<",
    closer: ">",
    reset: "",
    resetter: "$"
  }

  @doc ~S"""
  colorizes a binary according to options

      iex(1)> colorize("hello")
      "hello"

  # Default Options, resetting with `$`

  Here are the default options, a color is triggered by `<...`

      iex(2)> colorize("<green>")
      "\e[32m"

  We can also add bold for example

      iex(3)> colorize("<green, bold>success")
      "\e[32m\e[1msuccess"

  And resetting is simply achieved by a `$`

      iex(4)> colorize("$")
      "\e[0m"

  Which works in both orders, and note that the space after the `,` is not needed, we use 
  `$` to reset here!

      iex(5)> colorize("<bold,yellow>highlighted$normal")
      "\e[1m\e[33mhighlighted\e[0mnormal"

  We can use other color systems, like ANSI 256, also demonstrating how to escape `<` and `$`:

      iex(6)> colorize("256<color21><<$$")
      "256\e[38;5;21m<$"

  Dim, italic and named RGB colors are also at your disposal

      iex(7)> colorize("<dim, light_coral>and<italic>")
      "\e[2m\e[38;2;255;135;135mand\e[3m"

  # Using different options

  Maybe we want to open and close color definitions with the `!` character, note also that,
  in that case we need to double the `!` character, but not the `<` character anymore, to
  get them as verbatim text

      iex(8)> colorize("!red!!!<$", trigger: "!", closer: "!")
      "\e[31m!<\e[0m"

   # rgb

    In three decimal numbers....

      iex(9)> colorize("<12,255,0>rgb")
      "\e[38;2;12;255;0mrgb"


    or in hex

      iex(9)> colorize("<#0cff00>rgb")
      "\e[38;2;12;255;0mrgb"

  """

  @spec colorize(binary()) :: color_t()
  def colorize(line), do: colorize(line, [])

  @spec colorize(binary() | binaries(), map()) :: color_t()
  def colorize(line_or_lines, options)

  def colorize(line, options) when is_binary(line) do
    colorize([line], options)
  end

  def colorize(lines, options) do
    options1 = make_options(options)
    reset = if Map.get(options1, :auto), do: Color.color_code(:reset), else: ""

    lines
    |> Enum.map(&Minipeg.Parser.parse_string!(Parser.chunks_parser(options1), &1))
    # |> IO.inspect
    |> Enum.join(reset <> "\n")
  end

  def colorize!(line, parser, options) do
    reset = if Map.get(options, :auto), do: Color.color_code(:reset), else: ""
    with {:ok, parsed} <- Minipeg.Parser.parse_string(parser, line) do
      {:ok, parsed <> reset}
    end
  end

  def make_parser(options) do
    options 
    |> make_options()
    |> Parser.chunks_parser
  end

  def make_options(options) do
    options
    |> Enum.into(@default_options) 
  end

end

# SPDX-License-Identifier: AGPL-3.0-or-later
