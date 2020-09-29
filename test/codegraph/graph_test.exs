defmodule Codegraph.GraphTest do
  use ExUnit.Case, async: true

  alias Codegraph.Graph

  test "it can be created" do
    assert Graph.new()
  end

  test "an edge can be added" do
    g = Graph.new()
    assert Graph.add_edge(g, "1", "2")
  end

  test "two edges can be added" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    assert Graph.add_edge(g, "2", "3")
  end

  test "it can be represented in dot format" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "2", "3")
    g = Graph.add_edge(g, "3", "4")

    assert Graph.edges(g) == [{"1", "2"}, {"2", "3"}, {"3", "4"}]
  end

  test "edges can be limited to unique ones" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "1", "2")
    g = Graph.unique_edges(g)

    assert Graph.edges(g) == [{"1", "2"}]
  end

  test "edges can be filtered with a using a given fun" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")
    g = Graph.add_edge(g, "2", "3")
    g = Graph.filter(g, fn _, e2 -> e2 == "3" end)

    assert Graph.edges(g) == [{"2", "3"}]
  end

  test "edges can be mapped" do
    g = Graph.new()
    g = Graph.add_edge(g, "1", "2")

    g =
      Graph.map(g, fn
        "1" -> "one"
        "2" -> "two"
      end)

    assert Graph.edges(g) == [{"one", "two"}]
  end


  test "all the edges can be fetched as a list" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    g = Graph.add_edge(g, "b", "c")

    assert Graph.edges(g) == [{"a", "b"}, {"b", "c"}]
  end
end
