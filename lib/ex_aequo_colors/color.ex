defmodule ExAequoColors.Color do
  @moduledoc false

  @doc ~S"""
    Transform a string and color specifications into an IO Chardata
  """
  def color(subject, colorspec)

  def color(subject, colorspec) when is_atom(colorspec) do
    color(subject, [colorspec])
  end

  def color(subject, colorspec) do
    with {:ok, prefix, suffix} <- _extract_codes_from(colorspec) do
      {:ok, [prefix, subject, suffix]}
    end
  end

  defp _extract_codes_from(colorspec) do
    if Enum.member?(colorspec, :reset) do
      case colorspec |> List.delete(:reset) |> _extract_prefix_from() do
        {:ok, prefix} -> {prefix, "\e[0m"}
        error -> error
      end
    else
      case colorspec |> _extract_prefix_from() do
        {:ok, prefix} -> {prefix, ""}
        error -> error
      end
    end
  end

  defp _extract_prefix_from(colorspec) do
  end

  defp _to_kwd(list) do
    list
    |> Enum.map(&{&1, true})
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
