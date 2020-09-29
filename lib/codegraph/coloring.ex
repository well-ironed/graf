defmodule Codegraph.Coloring do
  @type color :: integer
  @type t :: %{integer => color}

  def from_color(color_output) do
    Regex.scan(~r/v(\d*) (\d*)/, color_output, capture: [1, 2])
    |> Enum.map(fn [vertex, color] -> {String.to_integer(vertex), String.to_integer(color)} end)
    |> Enum.into(%{})
  end
end
