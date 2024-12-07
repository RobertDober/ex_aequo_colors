defmodule ExAequoColors.Keywords do
  @moduledoc ~S"""
  Tools to access keywords (to be moved to ExAequoBase) 
  """

  @doc ~S"""

  Get first present value from a keyword list

      iex(1)> access_or([a: 1, b: 2], [:b, :a])
      2

      iex(2)> access_or([a: 1, b: 2], [:x, :y])
      nil 

  or an explicit default

      iex(3)> access_or([a: 1, b: 2], [:x, :y], :not_found)
      :not_found 
  
  """
  def access_or(kwd, accessors, default \\ nil) do
    accessors 
    |> Enum.reverse
    |> Enum.reduce(default, fn index, result ->
      Keyword.get(kwd, index, result)
    end)
  end
end
# SPDX-License-Identifier: AGPL-3.0-or-later
