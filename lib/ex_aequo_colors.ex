defmodule ExAequoColors do
  @version "0.1.0"

  alias __MODULE__.Color

  @moduledoc  ~S"""

  ### Features

  - ANSI Colors

  - Extended ANSI Colors

  - `colorize` CLI

  """

  @doc ~S"""
  add ANSI code for a color to a string

  We can use the 8 basic ANSI color codes

      iex(0)> color("This is red", :red)
      {:ok, "\e[31mThis is red"}

  """

  def color(subject, flags) do
    Color.color(tostring(subject), flags)
  end

  def version, do: @version
end

# SPDX-License-Identifier: AGPL-3.0-or-later
