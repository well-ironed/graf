defmodule B do
  alias FE.Maybe

  def bar do
    Maybe.just("baz")
  end
end
