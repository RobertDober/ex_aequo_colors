defmodule ExAequoColors.Ui do
  @moduledoc ~S"""
  Some convenience methods to output colorized messages
  """

  @doc ~S"""
  Just issuing an information

    iex(1)> capture_io(fn -> info("hello") end)
    "\e[34mINFO: \e[0mhello\n"

  And you can also color the message

    iex(2)> capture_io(fn -> info("hello", color: :blue) end)
    "\e[34mINFO: \e[0m\e[34mhello\e[0m\n"

  """

  def info(message, options \\ []) do
    _message(message, :info, "INFO: ", options)
  end

  @doc ~S"""

  The error function, by default

    iex(3)> capture_io(fn -> error("OH NO") end)
    "\e[31m\e[1mERROR: \e[0mOH NO\n"

  or to a different device

    iex(4)> capture_io(:stderr, fn -> error("OH NO", device: :stderr) end)
    "\e[31m\e[1mERROR: \e[0mOH NO\n"

  changing the label?

    iex(5)> capture_io(fn -> error("OH NO", label: "BAD") end)
    "\e[31m\e[1mBAD\e[0mOH NO\n"

  """
  def error(message, options \\ []) do
    _message(message, :error, "ERROR: ", options)
  end

  @doc ~S"""
  The warning function, by default

    iex(6)> capture_io(fn -> warning("Watch out!") end)
    "\e[33m\e[1mWARNING: \e[0mWatch out!\n"

  """
  def warning(message, options \\ []) do
    _message(message, :warning, "WARNING: ", options)
  end

  @colors %{
    info: "<blue>",
    error: "<red,bold>",
    warning: "<yellow,bold>"
  }

  defp _message(message, type, prefix, options) do
    device = Keyword.get(options, :device, :stdio)
    color = Map.fetch!(@colors, type)
    label = Keyword.get(options, :label, prefix)
    {message_color, reset} = _message_color(options)

    result =
      ExAequoColors.Colorizer.colorize(color <> label <> "$" <> message_color <> message <> reset)

    IO.puts(device, result)
  end

  defp _message_color(options) do
    case Keyword.get(options, :color) do
      nil -> {"", ""}
      color -> {"<#{color}>", "$"}
    end
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
