defmodule Test.ExAequoColors.PutsColTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  import ExAequoColors, only: [puts_col: 1, puts_col: 2]

  describe "puts_col" do
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

end
# SPDX-License-Identifier: Apache-2.0
