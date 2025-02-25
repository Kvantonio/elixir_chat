defmodule Chat.Application do
  use Application
  use N2O

  @port :application.get_env(:n2o, :port, 8000)
  @static :application.get_env(:n2o, :static, "priv/static")

  defp dispatch() do
    :cowboy_router.compile([
      {:_,
       [
         {~c"/ws/[...]", :n2o_cowboy, []},
         {~c"/[...]", :cowboy_static, {:dir, @static, []}}
       ]}
    ])
  end

  def start(_, _) do
    :cowboy.start_clear(:http, [{:port, @port}], %{env: %{dispatch: dispatch()}})
    Supervisor.start_link([], strategy: :one_for_one, name: Chat.Supervisor)
  end
end
