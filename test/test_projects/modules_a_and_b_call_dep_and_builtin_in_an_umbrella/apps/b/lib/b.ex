defmodule B do
  alias FE.Maybe

  def bar do
    Enum.map([1, 2, 3, 4], &Maybe.just/1)
  end
end
