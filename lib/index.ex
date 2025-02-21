defmodule Chat.Index do
  require NITRO
  require Logger

  def event(:init) do
    for room <- 1..3 do
      button =
        NITRO.button(
          id: "room#{room}",
          postback: "room_#{room}",
          body: "Кімната #{room}",
          source: [:user]
        )

      :nitro.insert_bottom(:rooms_list, button)
    end
  end

  def event(room) when is_binary(room) do
    user = :nitro.to_list(:nitro.q(:user))
    :n2o.user(user)
    :n2o.session(:room, room)
    :nitro.wire("ws.close();")
    :nitro.redirect(["/chat.htm?room=", room])
  end

  def event(unexpected), do: unexpected |> inspect() |> Logger.warning()
end
