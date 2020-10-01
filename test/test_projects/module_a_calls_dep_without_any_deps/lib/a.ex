defmodule A do
  alias FE.Maybe

  def foo do
    Maybe.just(:foo)
  end
end
