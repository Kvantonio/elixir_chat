defmodule Chat.Chat do
  require NITRO
  require N2O
  require Logger

  def event(:init) do
    room = Chat.Chat.room()
    :n2o.reg({:topic, room})
    :nitro.update(:heading, NITRO.h2(id: :heading, body: room))
    :nitro.update(:back, NITRO.button(id: :logout, postback: :back, body: "Back"))
    :nitro.update(:send, NITRO.button(id: :send, body: "Send", postback: :send, source: [:message]))
  end
  def event(:send), do: send(:nitro.q(:message))
  def event(:back) do
    :n2o.user([])
    :nitro.wire("ws.close();")
    :nitro.redirect("/index.htm")
  end
  def event({:client, {user, message}}) do
    :nitro.wire(NITRO.jq(target: :message, method: [:focus, :select]))
    :nitro.insert_top(:main_chat, NITRO.message(body: [NITRO.author(body: user), :nitro.jse(message)]))
  end
  def event(unexpected), do: unexpected |> inspect() |> Logger.warning()

  def room(), do: :n2o.session(:room)
  def user(), do: :n2o.user()

  def send(message) do
    room = Chat.Chat.room()
    user = user()
    :n2o.send({:topic, room}, N2O.client(data: {user, message}))
  end
end
