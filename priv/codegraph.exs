{_options, directories, []} =
OptionParser.parse(System.argv(), switches: [output: :string], aliases: [o: :output])

graph = Codegraph.from_projects(directories)

output =
  Jason.encode!(graph, pretty: true)

  IO.puts(output)
