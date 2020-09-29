defmodule Codegraph.Graph do
  @type vertex :: String.t()
  @type edge :: {vertex, vertex}

  alias Codegraph.VertexNumbering

  def new do
    []
  end

  def add_edge(graph, from, to) do
    [{from, to} | graph]
  end

  def unique_edges(graph) do
    Enum.uniq(graph)
  end

  def filter(graph, fun) do
    Enum.filter(graph, fn {e1, e2} -> fun.(e1, e2) end)
  end

  def map(graph, fun) do
    Enum.map(graph, fn {e1, e2} -> {fun.(e1), fun.(e2)} end)
  end

  def to_dot(graph) do
    edges =
      graph
      |> Enum.reverse()
      |> Enum.map(fn {from, to} -> "  \"#{from}\" -> \"#{to}\";" end)

    Enum.join(["digraph G {"] ++ edges ++ ["}"], "\n")
  end

  def from_dot(dot) do
    Regex.scan(~r/"(.*)" -> "(.*)"/, dot, capture: [1, 2])
    |> Enum.reverse()
    |> Enum.map(fn [from, to] -> {from, to} end)
  end

  def to_edge_list(graph) do
    numbers = VertexNumbering.from_graph(graph)
    graph = Enum.reverse(graph)

    edges =
      Enum.map(graph, fn {from, to} ->
        "e #{Map.fetch!(numbers, from)} #{Map.fetch!(numbers, to)}"
      end)

    Enum.join(["p col #{Enum.count(numbers)} #{Enum.count(edges)}" | edges], "\n")
  end

  def edges(graph), do: Enum.reverse(graph)
end
