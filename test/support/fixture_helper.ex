defmodule Test.Support.FixtureHelper do

  @base [__ENV__.file, "..", "..", "fixtures"]
  def fixture(local_segments)
  def fixture(local_segments) when is_list(local_segments) do
    Path.join(@base ++ local_segments)
  end
  def fixture(local_segments), do: fixture([local_segments])
  
end
# SPDX-License-Identifier: AGPL-3.0-or-later
