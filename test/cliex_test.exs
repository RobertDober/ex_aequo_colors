defmodule Test.CliexTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  import ExAequoColors.Cli

  describe "help" do
    test "--help" do
      help_text = capture_io(fn -> main(~W[--help]) end)
      assert String.starts_with?(help_text, "\e[1musage:")
    end
    test "-h" do
      help_text = capture_io(fn -> main(~W[-h]) end)
      assert String.starts_with?(help_text, "\e[1musage:\n\n")
    end
  end

  describe "error" do
    test "unknown argument" do
      error_text = capture_io(:stderr, fn -> main(~W[-x]) end)
      expected_prefix = "\e[1m\e[31mERROR:\e[0m{\"-x\", nil}\n<bold>usage:\n\n"
      assert String.starts_with?(error_text, expected_prefix)
    end
    
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
