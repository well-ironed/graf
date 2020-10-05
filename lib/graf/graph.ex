defmodule Graf.Graph do
  @type vertex :: String.t()
  @type edge :: {vertex, vertex}

  alias MapSet, as: Set

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
    Enum.map(graph, fn {e1, e2} -> fun.(e1, e2) end)
  end

  def edges(graph), do: Enum.reverse(graph)

  def to_map(graph) do
    without_sinks =
      graph
      |> Enum.group_by(&elem(&1, 0))
      |> Enum.into(%{}, fn {from, from_tos} ->
        {from, Enum.map(from_tos, &elem(&1, 1))}
      end)

    sinks =
      graph
      |> sinks()
      |> Enum.into(%{}, fn s -> {s, []} end)

    Map.merge(without_sinks, sinks)
  end

  def vertices(graph) do
    graph
    |> Enum.flat_map(fn {f, t} -> [f, t] end)
    |> Enum.uniq()
  end

  defp sinks(graph) do
    Set.difference(
      Set.new(vertices(graph)),
      Set.new(graph |> edges() |> Enum.map(&elem(&1, 0)))
    )
  end
end
