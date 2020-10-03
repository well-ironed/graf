defmodule A do
  alias FE.Maybe

  def foo do
    B.bar() |> Maybe.just() |> List.wrap()
  end
end
