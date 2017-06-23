defmodule HandsChatServer.ChatChannelControllerTest do
  use HandsChatServer.ConnCase

  alias HandsChatServer.ChatChannel
  @valid_attrs %{name: "some content", purpose: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_channel_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chat_channel = Repo.insert! %ChatChannel{}
    conn = get conn, chat_channel_path(conn, :show, chat_channel)
    assert json_response(conn, 200)["data"] == %{"id" => chat_channel.id,
      "name" => chat_channel.name,
      "purpose" => chat_channel.purpose}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chat_channel_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_channel_path(conn, :create), chat_channel: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ChatChannel, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_channel_path(conn, :create), chat_channel: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chat_channel = Repo.insert! %ChatChannel{}
    conn = put conn, chat_channel_path(conn, :update, chat_channel), chat_channel: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ChatChannel, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chat_channel = Repo.insert! %ChatChannel{}
    conn = put conn, chat_channel_path(conn, :update, chat_channel), chat_channel: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chat_channel = Repo.insert! %ChatChannel{}
    conn = delete conn, chat_channel_path(conn, :delete, chat_channel)
    assert response(conn, 204)
    refute Repo.get(ChatChannel, chat_channel.id)
  end
end
