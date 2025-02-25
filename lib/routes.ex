defmodule Chat.Routes do
  require N2O

  def finish(state, ctx), do: {:ok, state, ctx}

  def init(state, context) do
    %{path: path} = N2O.cx(context, :req)
    {:ok, state, N2O.cx(context, path: path, module: route(path))}
  end

  defp route(<<"/index", _::binary>>), do: Chat.Index
  defp route(<<"/chat", _::binary>>), do: Chat.Chat
  defp route(<<"/ws", p::binary>>), do: route(p)
end
