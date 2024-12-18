defmodule Test.ExAequoColors.PutsColTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  import ExAequoColors, only: [puts_col: 1, puts_col: 2]

  describe "puts_col, a string" do
    test "it puts colorized to stdout" do
      output = capture_io(fn ->
        puts_col("<bold>hello")
      end)
      assert output == "\e[1mhello\e[0m\n"
    end
    test "it puts colorized to stderr" do
      output = capture_io(:stderr, fn ->
        puts_col("<red>ERROR", :stderr)
      end)
      assert output == "\e[31mERROR\e[0m\n"
    end
  end

  describe "puts_col, a list" do
    test "it puts to stdout" do
      lines = [
        "<bold>important",
        "<dim>not so much",
      ]
      output = capture_io(fn ->
        puts_col(lines)
      end)
      assert output == "\e[1mimportant\e[0m\n\e[2mnot so much\e[0m\n"
      
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
