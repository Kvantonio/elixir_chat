defmodule Chat.Routes do
  use Plug.Router

  @app :application.get_env(:n2o, :app, :chat)
  @dir :application.get_env(:n2o, :upload, "priv/static")

  def route(<<"/ws", p::binary>>), do: route(p)
  def route(<<"index", _::binary>>), do: Chat.Index
  def route(<<"chat", _::binary>>), do: Chat.Chat

  def finish(state, ctx), do: {:ok, state, ctx}

  def init(state, context) do
    %{path: path} = N2O.cx(context, :req)
    {:ok, state, N2O.cx(context, path: path, module: route(path))}
  end

  plug(Plug.Static, at: "/", from: {@app, @dir})
  match _ do send_resp(conn, 404, "404") end
end
