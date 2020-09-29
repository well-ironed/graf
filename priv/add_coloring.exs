{options, [], []} =
  OptionParser.parse(System.argv(), strict: [dot: :string, col: :string], aliases: [d: :dot, c: :col])

graph = options[:dot] |> File.read!() |> Codegraph.Graph.from_dot()
coloring = options[:col] |> File.read!() |> Codegraph.Coloring.from_color()

colored_graph = Codegraph.ColoredGraph.from_graph_and_coloring(graph, coloring)

output = Codegraph.ColoredGraph.to_dot(colored_graph)

IO.puts output
