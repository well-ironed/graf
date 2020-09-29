defmodule CodegraphTest do
  use ExUnit.Case

  test "a module calling another module creates an edge on the graph" do
    # given
    project = "module_a_calls_b"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module calling another module non-tail recursively creates an edge on the graph" do
    # given
    project = "module_a_calls_b_no_tail_recursion"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module calling another module and being called by that module generates cycle on the graph" do
    # given
    project = "module_a_calls_b_and_b_calls_a"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => ["A"]}]
  end

  test "a module referencing another via capture creates an edge on the graph" do
    # given
    project = "module_a_references_function_from_b"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module referencing a module in another module in umbrella creates an edge on the graph" do
    # given
    project = "module_a_calls_b_in_umbrella"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module referencing a module in another module in different projects creates an edge on the graph" do
    # given
    project1 = "module_a_calls_b"
    project2 = "module_c_calls_b"
    project_compiled(project1)
    project_compiled(project2)
    heb_generator_compiled()

    # when
    output = heb_generated([project1, project2])

    # then
    assert Jason.decode!(output) ==
      [ %{"name" => "A", "imports" => ["B"]},
        %{"name" => "B", "imports" => []},
        %{"name" => "C", "imports" => ["B"]}
      ]
  end

  test "a module using a struct from another module creates an edge on the graph" do
    # given
    project = "module_a_uses_struct_from_b"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module matching on a struct from another module creates an edge on the graph" do
    # given
    project = "module_a_matches_on_a_struct_from_b"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B"]}, %{"name" => "B", "imports" => []}]
  end

  test "a module matching on multiple structs creates edges on the graph" do
    # given
    project = "module_a_matches_on_a_struct_from_b_and_c"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B", "C"]},
        %{"name" => "B", "imports" => []},
        %{"name" => "C", "imports" => []}
      ]
  end

  test "a module matching on multiple structs in different clauses creates edges on the graph" do
    # given
    project = "module_a_matches_on_a_struct_from_b_and_c_in_different_clauses"
    project_compiled(project)
    heb_generator_compiled()

    # when
    output = heb_generated(project)

    # then
    assert Jason.decode!(output) ==
      [%{"name" => "A", "imports" => ["B", "C"]},
        %{"name" => "B", "imports" => []},
        %{"name" => "C", "imports" => []}
      ]
  end
  defp project_compiled(project_name) do
    {_, 0} = System.cmd("mix", ["compile"], cd: project_dir(project_name))
  end

  defp heb_generator_compiled do
    {_, 0} = System.cmd("mix", ["compile"])
  end

  defp heb_generated(projects) when is_list(projects) do
    projects_dirs = Enum.map(projects, &project_dir/1)
    {output, 0} = System.cmd("mix", ["run", "priv/codegraph.exs"] ++ projects_dirs)
    output
  end

  defp heb_generated(project_name) do
    heb_generated([project_name])
  end

  defp project_dir(project_name) do
    Path.join([File.cwd!(), "test", "test_projects", project_name])
  end
end
