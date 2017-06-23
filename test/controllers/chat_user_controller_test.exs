defmodule HandsChatServer.ChatUserControllerTest do
  use HandsChatServer.ConnCase

  alias HandsChatServer.ChatUser
  @valid_attrs %{image: "some content", name: "some content", profile: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chat_user = Repo.insert! %ChatUser{}
    conn = get conn, chat_user_path(conn, :show, chat_user)
    assert json_response(conn, 200)["data"] == %{"id" => chat_user.id,
      "name" => chat_user.name,
      "image" => chat_user.image,
      "profile" => chat_user.profile}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chat_user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_user_path(conn, :create), chat_user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ChatUser, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_user_path(conn, :create), chat_user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chat_user = Repo.insert! %ChatUser{}
    conn = put conn, chat_user_path(conn, :update, chat_user), chat_user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ChatUser, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chat_user = Repo.insert! %ChatUser{}
    conn = put conn, chat_user_path(conn, :update, chat_user), chat_user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chat_user = Repo.insert! %ChatUser{}
    conn = delete conn, chat_user_path(conn, :delete, chat_user)
    assert response(conn, 204)
    refute Repo.get(ChatUser, chat_user.id)
  end
end
