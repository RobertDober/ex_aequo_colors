defmodule ExAequoColors.Colorizer.Parser do

  alias ExAequoColors.Color
  import Minipeg.{Combinators, Parsers}

  @moduledoc ~S"""
  Parses text and color definition chunks

  """

  def chunks_parser(options) do
    sequence([
      many_as_string(chunk_parser(options)),
      end_parser()
    ])  |> map(&List.first/1)
  end

  defp chunk_parser(options) do
    select([
      doubled_special_char_parser(options),
      color_definition_parser(options),
      reset_parser(options),
      text_parser(options)
    ])
  end

  defp color_code(ast) do
    ast
    |> IO.chardata_to_string
    |> String.to_atom 
    |> Color.color_code 
  end

  defp color_definition_parser(options) do
    sequence([
      literal_parser(options.trigger),
      inner_color_definition_parser(),
      literal_parser(options.closer)
    ])
    |> map(&Enum.at(&1, 1))
  end

  defp color_name_parser do
    sequence([
      char_parser(:alpha),
      many(char_parser(:word))
    ])
    |> map(&color_code/1) 
  end

  defp color_part_parser do
    select([
      color_name_parser(),
      rgb_dec_parser(),
      rgb_hex_parser()
    ])
  end

  defp dec_byte_parser do
    int_parser()
    |> satisfy(&Enum.member?(0..255, &1)) 
  end

  defp hex_bytes_parser do
    hex_digit_parser = char_parser("0123456789abcdefABCDEF")
    sequence([
      hex_digit_parser,
      hex_digit_parser,
      hex_digit_parser,
      maybe(
        sequence([
          hex_digit_parser,
          hex_digit_parser,
          hex_digit_parser,
        ]))])
  end

  defp doubled_special_char_parser(options) do
    trigger = options.trigger |> String.at(0)
    closer = options.closer |> String.at(0)
    resetter = options.resetter |> String.at(0)
    select([
      literal_parser(trigger <> trigger),
      literal_parser(closer <> closer),
      literal_parser(resetter <> resetter), #  |> debug(),
    ]) 
    |> map(&String.at(&1, 0)) 
  end

  defp inner_color_definition_parser do
    sequence([
      color_part_parser(),
      maybe_as_empty(second_color_part_parser())
    ])
  end

  defp reset_parser(options) do
    literal_parser(options.resetter)
    |> map(fn _ -> Color.color_code(:reset) end) 
  end

  defp rgb_color(rgb_ast)
  defp rgb_color([r, _, g, _, b]) do
    Color.color_code({r, g, b})
  end
  defp rgb_color(["#", [a, b, c,  [d, e, f]]]) do
    hex_to_dec(a, b, c, d, e, f)
    |> Color.color_code
  end
  defp rgb_color(["#", [a, b, c,  nil]]) do
    hex_to_dec(a, "0", b, "0", c, "0")
    |> Color.color_code
  end

  defp hex_to_dec(a, b, c, d, e, f) do
    with {r, ""} <- a <> b |> Integer.parse(16) do
      with {g, ""} <- c <> d |> Integer.parse(16) do
        with {b, ""} <- e <> f |> Integer.parse(16) do
          {r, g, b}
        end
      end
    end
  end

  defp rgb_dec_parser do
    sequence([
      dec_byte_parser(),
      char_parser(","),
      dec_byte_parser(),
      char_parser(","),
      dec_byte_parser(),
    ])
    |> map(&rgb_color/1) 
  end

  defp rgb_hex_parser do
    sequence([
      char_parser("#"),
      hex_bytes_parser(),
    ])
    |> map(&rgb_color/1)
  end

  defp second_color_part_parser do
    sequence([
      char_parser(","),
      ws_parser(),
      color_part_parser()
    ]) |> map(&Enum.at(&1, 2))
  end

  defp text_parser(options) do
    many_as_string(
      [
        options.trigger,
        options.resetter,
      ]
      |> Enum.map(&String.at(&1, 0)) 
      |> not_char_parser(), nil, 1)
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
