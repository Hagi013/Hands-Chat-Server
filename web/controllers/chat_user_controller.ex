defmodule HandsChatServer.ChatUserController do
  use HandsChatServer.Web, :controller

  alias HandsChatServer.ChatUser

  def index(conn, _params) do
    chat_users = Repo.all(ChatUser)
    render(conn, "index.json", chat_users: chat_users)
  end

  def create(conn, %{"chat_user" => chat_user_params}) do
    changeset = ChatUser.changeset(%ChatUser{}, chat_user_params)

    case Repo.insert(changeset) do
      {:ok, chat_user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", chat_user_path(conn, :show, chat_user))
        |> render("show.json", chat_user: chat_user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat_user = Repo.get!(ChatUser, id)
    render(conn, "show.json", chat_user: chat_user)
  end

  def update(conn, %{"id" => id, "chat_user" => chat_user_params}) do
    chat_user = Repo.get!(ChatUser, id)
    changeset = ChatUser.changeset(chat_user, chat_user_params)

    case Repo.update(changeset) do
      {:ok, chat_user} ->
        render(conn, "show.json", chat_user: chat_user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(HandsChatServer.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat_user = Repo.get!(ChatUser, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(chat_user)

    send_resp(conn, :no_content, "")
  end
end
