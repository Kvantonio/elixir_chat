defmodule Chat.Application do
  use Application

  def start(_, _) do
      children = [ { Bandit, scheme: :http, port: 8002, plug: Chat.WS },
                   { Bandit, scheme: :http, port: 8000, plug: Chat.Routes } ]
      Supervisor.start_link(children, strategy: :one_for_one, name: Chat.Supervisor)
  end
end
