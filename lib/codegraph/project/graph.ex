defmodule Codegraph.Project.Graph do
  alias MapSet, as: Set
  alias Codegraph.Graph
  alias Codegraph.Project.Modules

  def for_projects(projects_dirs, max_deps_depth, include_builtin) do
    projects_modules = Modules.projects_abstract_code(projects_dirs)
    deps_modules = Modules.deps_abstract_code(projects_dirs)

    graph = graph_from_abstract_code(projects_modules ++ deps_modules)

    graphed_modules = graphed_modules(
      projects_modules, deps_modules, graph, max_deps_depth)

    builtin_modules = builtin_modules(graph, projects_modules, deps_modules)

    graph
    |> Graph.filter(fn from, to ->
      from in graphed_modules and
        (to in graphed_modules or (include_builtin and to in builtin_modules))
    end)
    |> Graph.filter(fn from, to -> from != to end)
    |> Graph.map(fn from, to -> {no_elixir_prefix(from), no_elixir_prefix(to)} end)
  end

  defp builtin_modules(graph, projects_modules, deps_modules) do
    Set.difference(
      Set.new(Graph.vertices(graph)),
      Set.new(Modules.names(projects_modules) ++ Modules.names(deps_modules))
    )
  end

  defp graphed_modules(projects_modules, _deps_modules, _graph, 0) do
    projects_modules |> Modules.names() |> Set.new()
  end
  defp graphed_modules(projects_modules, deps_modules, graph, max_deps_depth) do
    modules = projects_modules |> Modules.names() |> Set.new()
    deps_modules = deps_modules |> Modules.names() |> Set.new()
    graph = Graph.to_map(graph)

    1..max_deps_depth
    |> Enum.reduce(modules, fn _, ms ->
      ms
      |> Enum.flat_map(&Map.get(graph, &1, []))
      |> Enum.reduce(ms, &Set.put(&2, &1))
    end)
    |> Enum.filter(fn m -> m in modules or m in deps_modules end)
  end

  defp graph_from_abstract_code(abstract_code) do
    Enum.reduce(abstract_code, Graph.new(), &module_calls/2)
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

  defp opcode_to_edges(module,
    {:call_ext_last, _, {:extfunc, another_module, _, _}, _}) do
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
