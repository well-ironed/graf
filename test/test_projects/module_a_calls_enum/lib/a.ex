defmodule A do
  def foo do
    list = [1, 2, 3, 4]
    Enum.map(list, fn x -> x * 2 end)
  end
end
