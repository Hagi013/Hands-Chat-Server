# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hands_chat_server,
  ecto_repos: [HandsChatServer.Repo]

# Configures the endpoint
config :hands_chat_server, HandsChatServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jivsnfxUnpRmoRjRPxNpIGWocypCg2YPiaHtUMCDbqTAAYQYQHiFgirGw9BQDScF",
  render_errors: [view: HandsChatServer.ErrorView, accepts: ~w(html json)],
  # pubsub: [name: HandsChatServer.PubSub,
  #          adapter: Phoenix.PubSub.PG2]
  pubsub: [name: HandsChatServer.PubSub,
           adapter: Phoenix.PubSub.Redis,
           node_name: "hands-redis",
           host: "hands-redis"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
