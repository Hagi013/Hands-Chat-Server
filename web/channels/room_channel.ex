defmodule HandsChatServer.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:hello", _auth_msg, socket) do
    {:ok, socket}
  end

  def join("rooms:" <> _private_room_id, _auth_msg, _socket) do
    {:error, %{reason: "unaithorized"}}
  end

  def handle_in("send_message", %{"message" => message}, socket) do
    IO.puts message
    broadcast! socket, "recieve", %{message: message}
    {:noreply, socket}
  end
end
