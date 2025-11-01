defmodule ExAequoColorsTest do
  use ExUnit.Case
  doctest ExAequoColors, import: true

  def version_rgx, do: ~r/\A \d+ \. \d+ \. \d+ /x

  test "version is defined and well formed" do
    assert Regex.match?(version_rgx(), ExAequoColors.version())
  end
end

# SPDX-License-Identifier: AGPL-3.0-or-later
