defmodule Elixible do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Elixible.Client.Storage, [])
    ]

    opts = [strategy: :one_for_one]

    Supervisor.start_link(children, opts)
  end
end
