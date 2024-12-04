defmodule ExAequoColors do
  @version "0.1.0"

  alias __MODULE__.{Color, Colorizer}

  @moduledoc  ~S"""

  ### Features

  - ANSI Colors

  - Extended ANSI Color, suffixs

  - `colorize` CLI

  """

  @doc ~S"""

  ## ANSI code for a color to a string

  We can use the 8 basic ANSI color codes

      iex(1)> col("This is red", :red)
      "\e[31mThis is red"

  Or we can add a reset

      iex(2)> col("This is red", :red, :reset)
      "\e[31mThis is red\e[0m"

  Which can also be achieved by means of the `colr` function

      iex(3)> colr("This is red", :red)
      "\e[31mThis is red\e[0m"

  We can also add bold or dim

      iex(4)> col("Bold and blue", :bold, :blue)
      "\e[1m\e[34mBold and blue"

      iex(5)> col("Green and dim", :green, :dim)
      "\e[32m\e[2mGreen and dim"

  """

  def col(subject, flag) do
    Color.color(to_string(subject), [flag])
  end
  def col(subject, flag1, flag2) do
    Color.color(to_string(subject), [flag1, flag2])
  end
  def colr(subject, flag) do
    Color.color_reset(to_string(subject), [flag])
  end
  def colr(subject, flag1, flag2) do
    Color.color_reset(to_string(subject), [flag1, flag2])
  end

  @doc """
  Convenience delegation
  """
  defdelegate colorize(line, options), to: Colorizer
  defdelegate colorize(line), to: Colorizer

  def version, do: @version
end

# SPDX-License-Identifier: AGPL-3.0-or-later
