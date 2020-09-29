{options, directories, []} =
OptionParser.parse(System.argv(), switches: [output: :string], aliases: [o: :output])

graph = Codegraph.from_projects(directories)

output =
  #case options do
    #[output: "col"] -> Codegraph.Graph.to_edge_list(graph)
    #_ -> Codegraph.Graph.to_dot(graph)
  #end
  Jason.encode!(graph, pretty: true)

  IO.puts(output)
