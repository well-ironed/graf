defmodule A do
  def foo(data) do
    FooProtocol.bar(data)
  end

  defimpl FooProtocol, for: Map do
    def bar(map), do: map_size(map)
  end
end
