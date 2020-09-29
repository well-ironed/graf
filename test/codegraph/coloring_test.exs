defmodule Codegraph.ColoringTest do
  use ExUnit.Case, async: true

  alias Codegraph.Coloring

  test "it can be created from the color command output" do
    output = """
    v1 0
    v2 1
    v3 2
    """

    assert Coloring.from_color(output) == %{1 => 0, 2 => 1, 3 => 2}
  end
end
