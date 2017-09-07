defmodule HandsChatServer.ChatMessageTest do
  use HandsChatServer.ModelCase

  alias HandsChatServer.ChatMessage

  @valid_attrs %{image: "some content", text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ChatMessage.changeset(%ChatMessage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ChatMessage.changeset(%ChatMessage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
