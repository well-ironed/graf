{options, directories, []} = OptionParser.parse(
  System.argv(),
  switches: [output: :string, max_deps_depth: :integer, builtin: :boolean],
  aliases: [o: :output]
)

max_deps_depth = Keyword.get(options, :max_deps_depth, 0)
include_builtin = Keyword.get(options, :builtin, false)
graph = Codegraph.from_projects(directories, max_deps_depth, include_builtin)

output = Jason.encode!(graph, pretty: true)

IO.puts(output)
