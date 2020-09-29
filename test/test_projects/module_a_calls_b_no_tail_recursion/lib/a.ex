defmodule A do
  def foo() do
    B.bar() <> " and baz"
  end
end
