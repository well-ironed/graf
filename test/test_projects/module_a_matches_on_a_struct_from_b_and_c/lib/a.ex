defmodule A do
  def foo(%B{foo: foo}, %C{bar: bar}) do
    {foo, bar}
  end
end
