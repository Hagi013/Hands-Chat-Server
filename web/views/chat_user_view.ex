defmodule HandsChatServer.ChatUserView do
  use HandsChatServer.Web, :view

  def render("index.json", %{chat_users: chat_users}) do
    %{data: render_many(chat_users, HandsChatServer.ChatUserView, "chat_user.json")}
  end

  def render("show.json", %{chat_user: chat_user}) do
    %{data: render_one(chat_user, HandsChatServer.ChatUserView, "chat_user.json")}
  end

  def render("chat_user.json", %{chat_user: chat_user}) do
    %{id: chat_user.id,
      name: chat_user.name,
      image: chat_user.image,
      profile: chat_user.profile}
  end
end
