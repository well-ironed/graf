defmodule Codegraph.ColoredGraphTest do
  use ExUnit.Case, async: true

  alias Codegraph.{Graph, Coloring, ColoredGraph}

  test "it can be created from a graph and coloring" do
    g = Graph.from_dot("""
           digraph G {
             "A" -> "B";
             "C" -> "B";
           }
        """)
    coloring = Coloring.from_color("""
      v1 0
      v2 1
      v3 2
    """)

    colored_graph = ColoredGraph.from_graph_and_coloring(g, coloring)
    assert ColoredGraph.to_dot(colored_graph) <> "\n" ==
    """
    digraph G {
      "A" -> "B";
      "C" -> "B";
      "A" [color=1];
      "B" [color=2];
      "C" [color=3];
    }
    """
  end
end
