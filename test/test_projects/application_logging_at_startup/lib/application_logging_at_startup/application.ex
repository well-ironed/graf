defmodule ApplicationLoggingAtStartup.Application do
  @moduledoc false

  use Application
  require Logger

  def start(_type, _args) do
    children = []

    Logger.error("this is an example log")

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApplicationLoggingAtStartup.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
