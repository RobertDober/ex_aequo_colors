defmodule ExAequoColors.Cli do

  @moduledoc false

  defdelegate main(args), to: ExAequoColors.Cli.Implementation

end
# SPDX-License-Identifier: AGPL-3.0-or-later
