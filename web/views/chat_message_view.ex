defmodule HandsChatServer.ChatMessageView do
  use HandsChatServer.Web, :view

  def render("index.json", %{chat_messages: chat_messages}) do
    # IO.inspect chat_messages
    IO.inspect render_many(chat_messages, HandsChatServer.ChatMessageView, "chat_message.json")
    %{data: render_many(chat_messages, HandsChatServer.ChatMessageView, "chat_message.json")}
  end

  def render("show.json", %{chat_message: chat_message}) do
    %{data: render_one(chat_message, HandsChatServer.ChatMessageView, "chat_message.json")}
  end

  def render("chat_message.json", %{chat_message: chat_message}) do
    %{id: chat_message.id,
      from_chat_user: chat_message.from_chat_user,
      chat_channel: chat_message.chat_channel,
      text: chat_message.text,
      image: chat_message.image}
  end
end
