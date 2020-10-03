{options, directories, []} = OptionParser.parse(
  System.argv(),
  switches: [output: :string, max_deps_depth: :integer],
  aliases: [o: :output]
)

max_deps_depth = Keyword.get(options, :max_deps_depth, 0)
graph = Codegraph.from_projects(directories, max_deps_depth)

output = Jason.encode!(graph, pretty: true)

IO.puts(output)
