defmodule HandsChatServer.PageController do
  use HandsChatServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
