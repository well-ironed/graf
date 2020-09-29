defmodule A do
  def foo(%B{foo: _} = b) do
    %B{b | foo: "bar"}
  end
end
