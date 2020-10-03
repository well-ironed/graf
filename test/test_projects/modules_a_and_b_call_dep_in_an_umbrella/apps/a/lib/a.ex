defmodule A do
  alias FE.Maybe

  def foo do
    Maybe.just(B.bar())
  end
end
