defmodule HandsChatServer.ChatChannelView do
  use HandsChatServer.Web, :view

  def render("index.json", %{chat_channels: chat_channels}) do
    %{data: render_many(chat_channels, HandsChatServer.ChatChannelView, "chat_channel.json")}
  end

  def render("show.json", %{chat_channel: chat_channel}) do
    %{data: render_one(chat_channel, HandsChatServer.ChatChannelView, "chat_channel.json")}
  end

  def render("chat_channel.json", %{chat_channel: chat_channel}) do
    %{id: chat_channel.id,
      name: chat_channel.name,
      purpose: chat_channel.purpose}
  end
end
