defmodule Test.ExAequoColors.ColorizerTest do
  use ExUnit.Case

  import ExAequoColors.Colorizer
  doctest ExAequoColors.Colorizer, import: true 

  describe "rgb" do
    test "in dec" do
      assert colorize("<23,240,31>rgb dec") == "\e[38;2;23;240;31mrgb dec"
    end
    test "in hex, 6 bytes" do
      assert colorize("<#17f01f>rgb hex 6") == "\e[38;2;23;240;31mrgb hex 6"
    end
    test "in hex, 3 bytes" do
      assert colorize("<#fd8>rgb hex 3") == "\e[38;2;240;208;128mrgb hex 3"
    end
    test "in hex, 3 bytes, and auto" do
      assert colorize("<#fd8>rgb hex 3", auto: true) == "\e[38;2;240;208;128mrgb hex 3\e[0m"
    end
  end
  
end
# SPDX-License-Identifier: AGPL-3.0-or-later
