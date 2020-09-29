defmodule A do
  def foo do
    1..100
    |> Enum.map(&B.foo/1)
  end
end
