defmodule A do
  def foo(%B{foo: foo}) do
    foo
  end

  def foo(%C{bar: bar}) do
    bar
  end
end
