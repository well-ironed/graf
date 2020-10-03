defmodule Codegraph do
  alias Codegraph.{Graph, Project}

  def from_projects(projects_dirs, max_deps_depth \\ 0, include_builtin \\ false) do
    projects_dirs
    |> Project.Graph.for_projects(max_deps_depth, include_builtin)
    |> Graph.to_map()
    |> Enum.sort_by(fn {from, _} -> from end)
    |> Enum.map(fn {source, targets} ->
      %{name: source, imports: Enum.uniq(targets) |> Enum.sort()}
    end)
  end
end
