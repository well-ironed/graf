defmodule Codegraph.VertexNumbering do
  @type t :: %{Graph.vertex() => integer}

  alias Codegraph.Graph

  def from_graph(graph) do
    edges = Graph.edges(graph)

    {numbers, _} =
      Enum.reduce(edges, {%{}, 1}, fn {from, to}, {numbers, next_number} ->
        {numbers, next_number} = vertex_number(from, numbers, next_number)
        vertex_number(to, numbers, next_number)
      end)

    Enum.into(numbers, %{})
  end

  def vertex_with_number(numbering, number) do
    {vertex, _} = Enum.find(numbering, fn {_, n} -> n == number end)
    vertex
  end

  defp vertex_number(vertex, numbers, next) do
    case Map.get(numbers, vertex) do
      nil -> {Map.put(numbers, vertex, next), next + 1}
      _number -> {numbers, next}
    end
  end
end
