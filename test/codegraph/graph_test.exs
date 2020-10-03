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
    g = Graph.add_edge(g, 1, 2)

    g =
      Graph.map(g, fn x, y -> {x*2, y+3} end)

    assert Graph.edges(g) == [{2, 5}]
  end


  test "all the edges can be fetched as a list" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    g = Graph.add_edge(g, "b", "c")

    assert Graph.edges(g) == [{"a", "b"}, {"b", "c"}]
  end

  test "a empty graph can be represented as a map" do
    g = Graph.new()
    assert Graph.to_map(g) == %{}
  end

  test "a graph with two edges can be represented as map of source and target vertex" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    g = Graph.add_edge(g, "b", "a")
    assert Graph.to_map(g) == %{"a" => ["b"], "b" => ["a"]}
  end

  test "a graph with a vertex without outgoing edges is returned in the map" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    assert Graph.to_map(g) == %{"a" => ["b"], "b" => []}
  end

  test "a graph with vertex that's a target to multiple vertices is returned once" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "c")
    g = Graph.add_edge(g, "b", "c")
    assert Graph.to_map(g) == %{"a" => ["c"], "b" => ["c"], "c" => []}
  end

  test "a graph with more edges can be represented as map of source and target vertex" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    g = Graph.add_edge(g, "a", "c")
    g = Graph.add_edge(g, "A", "d")
    g = Graph.add_edge(g, "A", "e")
    g = Graph.add_edge(g, "A", "f")
    assert Graph.to_map(g) == %{
      "a" => ["c", "b"],
      "A" => ["f", "e", "d"],
      "b" => [],
      "c" => [],
      "d" => [],
      "e" => [],
      "f" => []
    }
  end

  test "all vertices can be returned for an empty graph" do
    g = Graph.new()
    assert Graph.vertices(g) == []
  end

  test "all vertices can be returned for a graph with one edge" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    assert Graph.vertices(g) == ["a", "b"]
  end

  test "all vertices can be returned for a graph with more edges" do
    g = Graph.new()
    g = Graph.add_edge(g, "a", "b")
    g = Graph.add_edge(g, "b", "c")
    g = Graph.add_edge(g, "b", "d")
    assert Graph.vertices(g) == ["b", "d", "c", "a"]
  end
end
