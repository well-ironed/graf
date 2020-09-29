defmodule Codegraph.Graph do
  @type vertex :: String.t()
  @type edge :: {vertex, vertex}

  def new, do: []

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

  def edges(graph), do: Enum.reverse(graph)
end
