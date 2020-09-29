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

  defp function_calls({:function, _, _, _, opcodes}, module, graph) do
    opcodes
    |> Enum.flat_map(&opcode_to_edges(module, &1))
    |> Enum.reduce(graph, fn {from, to}, graph ->
      Graph.add_edge(graph, from, to)
    end)
  end

  defp opcode_to_edges(module,
    {:call_ext_only, _, {:extfunc, another_module, _, _}}) do
    [{module, another_module}]
  end

  defp opcode_to_edges(module, {:call_ext, _, {:extfunc, another_module, _, _}}) do
    [{module, another_module}]
  end

  defp opcode_to_edges(module, {:move, {:literal, literal}, _}) do
    if is_function(literal) do
      case :erlang.fun_info(literal, :type) do
        {:type, :external} ->
          {:module, another_module} = :erlang.fun_info(literal, :module)
          [{module, another_module}]

        _ ->
          []
      end
    else
        []
    end
  end

  defp opcode_to_edges(module, {:test, :is_eq_exact, _, comparisons}) do
    comparisons
    |> select_elixir_modules()
    |> Enum.map(&{module, &1})
  end

  defp opcode_to_edges(module, {:select_val, _, _, {:list, values}}) do
    values
    |> select_elixir_modules()
    |> Enum.map(&{module, &1})
  end

  defp opcode_to_edges(_module, _) do
    []
  end

  defp select_elixir_modules(proplist) do
    proplist
    |> Enum.filter(fn
      {:atom, maybe_another_module} -> is_elixir_module(maybe_another_module)
      _ -> false
    end)
    |> Enum.map(fn {:atom, another_module} -> another_module end)
  end

  defp no_elixir_prefix(module) do
    case Atom.to_string(module) do
      "Elixir." <> rest -> rest
      other -> other
    end
  end

  defp is_elixir_module(maybe_module) do
    case Atom.to_string(maybe_module) do
      "Elixir." <> _ -> true
       _other -> false
    end
  end
end
