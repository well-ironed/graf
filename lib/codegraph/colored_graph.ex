defmodule Codegraph.ColoredGraph do

  defstruct [:graph, :coloring]

  alias Codegraph.{Graph, VertexNumbering}

  @colors %{0 => "red", 1 => "green", 2 => "blue", 3 => "orange", 4 => "violet", 5 => "skyblue"}

  def from_graph_and_coloring(graph, coloring) do
    %__MODULE__{graph: graph, coloring: coloring}
  end


  def to_dot(%__MODULE__{graph: graph, coloring: coloring}) do
    numbering = VertexNumbering.from_graph(graph)

    edges =
      graph
      |> Graph.edges()
      |> Enum.map(fn {from, to} -> "  \"#{from}\" -> \"#{to}\";" end)

    vertices =
      coloring
      |> Enum.map(fn {vertex, color} ->
        "  \"#{VertexNumbering.vertex_with_number(numbering, vertex)}\" [color=#{@colors[color]}];"
      end)

    Enum.join(["digraph G {"] ++ edges ++ vertices ++ ["}"], "\n")
  end

end
