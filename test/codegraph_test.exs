defmodule CodegraphTest do
  use ExUnit.Case

  test "a module calling another module creates an edge on the graph" do
    project = "module_a_calls_b"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
           }
           """
  end

  test "a module calling another module non-tail recursively creates an edge on the graph" do
    project = "module_a_calls_b_no_tail_recursion"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
           }
           """
  end

  test "a module calling another module and being called by that module generates cycle on the graph" do
    project = "module_a_calls_b_and_b_calls_a"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
             "B" -> "A";
           }
           """
  end

  test "a module referencing another via capture creates an edge on the graph" do
    project = "module_a_references_function_from_b"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
           }
           """
  end

  test "a module referencing a module in another module in umbrella creates an edge on the graph" do
    project = "module_a_calls_b_in_umbrella"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
           }
           """
  end

  test "a module referencing a module in another module in different projects creates an edge on the graph" do
    project1 = "module_a_calls_b"
    project2 = "module_c_calls_b"
    given_project_compiled(project1)
    given_project_compiled(project2)

    output = when_project_graphed([project1, project2])

    assert output == """
           digraph G {
             "A" -> "B";
             "C" -> "B";
           }
           """
  end

  test "a module using a struct from another module creates an edge on the graph" do
    project = "module_a_uses_struct_from_b"
    given_project_compiled(project)

    output = when_project_graphed(project)

    assert output == """
           digraph G {
             "A" -> "B";
           }
           """
  end

  test "dependency graph can be returned as edge list for coloring" do
    project = "module_a_calls_b_and_b_calls_a"
    given_project_compiled(project)

    output = when_project_graphed(project, ["-o", "col"])

    assert output == """
           p col 2 2
           e 1 2
           e 2 1
           """
  end

  test "coloring can be added to an existing graph" do
    dot = given_file("""
           digraph G {
             "A" -> "B";
             "C" -> "B";
           }
        """)
    coloring = given_file("""
      v1 0
      v2 1
      v3 2
    """)

    output = when_coloring_added(dot, coloring)
    assert output == """
    digraph G {
      "A" -> "B";
      "C" -> "B";
      "A" [color=1];
      "B" [color=2];
      "C" [color=3];
    }
    """
  end

  defp given_project_compiled(project_name) do
    {_, 0} = System.cmd("mix", ["compile"], cd: project_dir(project_name))
  end

  defp when_project_graphed(_, options \\ [])
  defp when_project_graphed(projects, options) when is_list(projects) do
    projects_dirs = Enum.map(projects, &project_dir/1)
    {output, 0} = System.cmd("mix", ["run", "priv/codegraph.exs"] ++ options ++  projects_dirs)
    output
  end

  defp when_project_graphed(project_name, options), do: when_project_graphed([project_name], options)

  defp project_dir(project_name) do
    Path.join([File.cwd!(), "test", "test_projects", project_name])
  end

  defp given_file(content) do
    {filename, 0} = System.cmd("mktemp", [])
    filename = String.trim(filename)
    :ok = File.write!(filename, content)
    filename
  end

  defp when_coloring_added(dot, coloring) do
    {output, 0} = System.cmd("mix", ["run", "priv/add_coloring.exs", "-d", dot, "-c", coloring])
    output
  end
end
