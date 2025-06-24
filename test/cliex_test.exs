defmodule Test.CliexTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  import ExAequoColors.Cli
  import Test.Support.FixtureHelper

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

  @version_rgx ~r/\Acolorize \s v \d \./x
  describe "version" do
    test "--version" do
      version_text = capture_io(fn -> main(~W[--version]) end)
      assert Regex.match?(@version_rgx, version_text)
    end
    test "-v" do
      version_text = capture_io(fn -> main(~W[-v]) end)
      assert Regex.match?(@version_rgx, version_text)
    end
  end

  describe "error" do
    test "unknown argument" do
      error_text = capture_io(:stderr, fn -> main(~W[-x]) end)
      expected_prefix = "\e[1m\e[31mERROR:\e[0m{\"-x\", nil}\n<bold>usage:\n\n"
      assert String.starts_with?(error_text, expected_prefix)
    end
  end

  describe "bold" do
    test "to boldly go" do
      file = fixture("bold")
      output_text = capture_io(fn -> main([file]) end)
      
    end
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
