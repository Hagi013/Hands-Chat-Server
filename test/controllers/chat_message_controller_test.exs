defmodule HandsChatServer.ChatMessageControllerTest do
  use HandsChatServer.ConnCase

  alias HandsChatServer.ChatMessage
  @valid_attrs %{image: "some content", text: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, chat_message_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    chat_message = Repo.insert! %ChatMessage{}
    conn = get conn, chat_message_path(conn, :show, chat_message)
    assert json_response(conn, 200)["data"] == %{"id" => chat_message.id,
      "from" => chat_message.from,
      "channel" => chat_message.channel,
      "text" => chat_message.text,
      "image" => chat_message.image}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, chat_message_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, chat_message_path(conn, :create), chat_message: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ChatMessage, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, chat_message_path(conn, :create), chat_message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    chat_message = Repo.insert! %ChatMessage{}
    conn = put conn, chat_message_path(conn, :update, chat_message), chat_message: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ChatMessage, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    chat_message = Repo.insert! %ChatMessage{}
    conn = put conn, chat_message_path(conn, :update, chat_message), chat_message: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    chat_message = Repo.insert! %ChatMessage{}
    conn = delete conn, chat_message_path(conn, :delete, chat_message)
    assert response(conn, 204)
    refute Repo.get(ChatMessage, chat_message.id)
  end
end
