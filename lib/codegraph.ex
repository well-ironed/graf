defmodule Codegraph do
  alias Codegraph.Graph

  def from_projects(projects_dirs) do
    disassembled_modules =
      projects_dirs
      |> Enum.flat_map(&beam_files/1)
      |> Enum.map(&:beam_disasm.file/1)

    modules = modules(disassembled_modules)

    edges = 
      Enum.reduce(disassembled_modules, Graph.new(), &module_calls/2)
      |> Graph.edges()
      |> Enum.filter(fn {from, to} -> from in modules and to in modules end)
      |> Enum.reject(fn {from, to} -> from == to end)
      |> Enum.map(fn {from, to} -> {no_elixir_prefix(from), no_elixir_prefix(to)} end)

    source_vertices =
      edges
      |> Enum.group_by(&(elem(&1, 0)))
      |> Enum.map(fn {source, edges} -> {source, Enum.map(edges, fn {_, to} -> to end)} end)

    source_vertices_map = Map.new(source_vertices)

    sink_vertices =
      edges
      |> Enum.filter(fn {_, to} -> Map.get(source_vertices_map, to) == nil end)
      |> Enum.map(fn {_, to} -> {to, []} end)
      |> Enum.uniq()

    source_vertices ++ sink_vertices
    |> Enum.sort_by(fn {from, _} -> from end)
    |> Enum.map(fn {source, targets} -> %{name: source, imports: Enum.uniq(targets)} end)
    
    #|> Graph.unique_edges()
    #|> Graph.filter(fn from, to -> from in modules and to in modules end)
    #|> Graph.filter(fn from, to -> from != to end)
    #|> Graph.map(&no_elixir_prefix/1)
  end

  defp modules(disassembled_modules) do
    disassembled_modules
    |> Enum.map(fn {:beam_file, module, _, _, _, _} -> module end)
  end

  defp beam_files(project_dir) do
    [project_dir, "**", "ebin", "*.beam"]
    |> Path.join()
    |> Path.wildcard()
    |> Enum.map(&String.to_charlist/1)
  end

  defp module_calls({:beam_file, module, _, _, _, functions}, graph) do
    Enum.reduce(functions, graph, &function_calls(&1, module, &2))
  end

  defp function_calls({:function, :__info__, 1, _, _}, _, graph), do: graph
  defp function_calls({:function, :module_info, 0, _, _}, _, graph), do: graph
  defp function_calls({:function, :module_info, 1, _, _}, _, graph), do: graph

  defp function_calls({:function, _, _, _, bytecode}, module, graph) do
    opcode_to_edge(bytecode, module, graph)
  end

  defp opcode_to_edge([], _, graph) do
    graph
  end

  defp opcode_to_edge(
         [{:call_ext_only, _, {:extfunc, another_module, _, _}} | rest],
         module,
         graph
       ) do
    graph = Graph.add_edge(graph, module, another_module)
    opcode_to_edge(rest, module, graph)
  end

  defp opcode_to_edge([{:call_ext, _, {:extfunc, another_module, _, _}} | rest], module, graph) do
    graph = Graph.add_edge(graph, module, another_module)
    opcode_to_edge(rest, module, graph)
  end

  defp opcode_to_edge([{:move, {:literal, literal}, _} | rest], module, graph) do
    graph =
      if is_function(literal) do
        case :erlang.fun_info(literal, :type) do
          {:type, :external} ->
            {:module, another_module} = :erlang.fun_info(literal, :module)
            Graph.add_edge(graph, module, another_module)

          _ ->
            graph
        end
      else
        graph
      end

    opcode_to_edge(rest, module, graph)
  end

  defp opcode_to_edge(
         [
           {:get_map_elements, _, _, {:list, [{:atom, :__struct__} | _]}},
           {:test, :is_eq_exact, _, [_, {:atom, another_module}]} | rest
         ],
         module,
         graph
       ) do
    graph = Graph.add_edge(graph, module, another_module)
    opcode_to_edge(rest, module, graph)
  end

  defp opcode_to_edge([_ | rest], module, graph) do
    opcode_to_edge(rest, module, graph)
  end

  defp no_elixir_prefix(module) do
    case Atom.to_string(module) do
      "Elixir." <> rest -> rest
      other -> other
    end
  end
end
