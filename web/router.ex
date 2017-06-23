defmodule HandsChatServer.Router do
  use HandsChatServer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug # 追加
  end

  scope "/", HandsChatServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", HandsChatServer do
    pipe_through :api
    resources "/chat_channels", ChatChannelController, except: [:new, :edit]
    options "/chat_channels", ChatChannelController, :options # 追加
    options "/chat_channels/:id", ChatChannelController, :options # 追加

    resources "/chat_users", ChatUserController, except: [:new, :edit]
    options "/chat_users", ChatUserController, :options # 追加
    options "/chat_users/:id", ChatUserController, :options # 追加

    resources "/chat_messages", ChatMessageController, except: [:new, :edit]
    options "/chat_messages", ChatMessageController, :options # 追加
    options "/chat_messages/:id", ChatMessageController, :options # 追加
  end
end
