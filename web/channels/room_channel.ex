defmodule HandsChatServer.RoomChannel do
  use Phoenix.Channel
  alias HandsChatServer.ChatUser

  def join("rooms:lobby", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:hello", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, socket) do
    {:ok, socket}
  end

  def handle_in("send_message", %{"message" => message}, socket) do
    IO.puts message
    IO.inspect socket
    broadcast! socket, "recieve", %{message: message}
    {:noreply, socket}
  end
end
