defmodule HandsChatServer.ChatMessageController do
  use HandsChatServer.Web, :controller

  alias HandsChatServer.ChatMessage

  def index(conn, _params) do
    chat_messages = Repo.all(ChatMessage) |> Repo.preload([:from_chat_user]) |> Repo.preload([:chat_channel])
    render(conn, "index.json", chat_messages: chat_messages)
  end

  def create(conn, %{"chat_message" => chat_message_params}) do
    changeset = ChatMessage.changeset(%ChatMessage{}, chat_message_params)

    case Repo.insert(changeset) do
      {:ok, chat_message} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", chat_message_path(conn, :show, chat_message))
        |> render("show.json", chat_message: chat_message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_message = Repo.get!(ChatMessage, id)
    render(conn, "show.json", chat_message: chat_message)
  end

  def update(conn, %{"id" => id, "chat_message" => chat_message_params}) do
    chat_message = Repo.get!(ChatMessage, id)
    changeset = ChatMessage.changeset(chat_message, chat_message_params)

    case Repo.update(changeset) do
      {:ok, chat_message} ->
        render(conn, "show.json", chat_message: chat_message)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat_message = Repo.get!(ChatMessage, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chat_message)

    send_resp(conn, :no_content, "")
  end
end
