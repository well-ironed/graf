defmodule Codegraph.VertexNumberingTest do
  use ExUnit.Case, async: true

  alias Codegraph.{Graph, VertexNumbering}

  test "it can be created from a graph" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "1", "4")
    g = Graph.add_edge(g, "2", "3")

    assert VertexNumbering.from_graph(g) == %{"1" => 1, "2" => 2, "4" => 3, "3" => 4}
  end

  test "vertex for a given number can be retrieved" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "1", "4")
    g = Graph.add_edge(g, "2", "3")

    numbering = VertexNumbering.from_graph(g)

    assert VertexNumbering.vertex_with_number(numbering, 4) == "3"
  end
end
