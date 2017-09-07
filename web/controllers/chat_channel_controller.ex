defmodule HandsChatServer.ChatChannelController do
  use HandsChatServer.Web, :controller

  alias HandsChatServer.ChatChannel

  def index(conn, _params) do
    chat_channels = Repo.all(ChatChannel) |> Repo.preload(:members)
    render(conn, "index.json", chat_channels: chat_channels)
  end

  def create(conn, %{"chat_channel" => chat_channel_params}) do
    changeset = ChatChannel.changeset(%ChatChannel{}, chat_channel_params)

    case Repo.insert(changeset) do
      {:ok, chat_channel} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", chat_channel_path(conn, :show, chat_channel))
        |> render("show.json", chat_channel: chat_channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_channel = Repo.get!(ChatChannel, id)
    render(conn, "show.json", chat_channel: chat_channel)
  end

  def update(conn, %{"id" => id, "chat_channel" => chat_channel_params}) do
    chat_channel = Repo.get!(ChatChannel, id)
    changeset = ChatChannel.changeset(chat_channel, chat_channel_params)

    case Repo.update(changeset) do
      {:ok, chat_channel} ->
        render(conn, "show.json", chat_channel: chat_channel)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat_channel = Repo.get!(ChatChannel, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chat_channel)

    send_resp(conn, :no_content, "")
  end
end
