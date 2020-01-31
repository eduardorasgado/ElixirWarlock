# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discussapp,
  ecto_repos: [Discussapp.Repo]

# Configures the endpoint
config :discussapp, Discussapp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qTh3S5g+F8mebPnMj+HMfE5iTw4BiSHuBKVmB49T+LSf0zQYe394QyFbO232T1ad",
  render_errors: [view: Discussapp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discussapp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# updating uberauth configuration by adding github as provider
config :ueberauth, Ueberauth,
  providers: [
    # to be able to take user email in callback ueberauth when signing up using github
    github: { Ueberauth.Strategy.Github, [
      #if we want to use full user data we should include "user, user:email"
      default_scope: "public_repo, user:email"
    ] }
  ]

# https://github.com/ueberauth/ueberauth_github
# configuring github provider options(important data)
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("DISCUSSAPP_PHOENIX_CLIENT_ID"),
  client_secret: System.get_env("DISCUSSAPP_PHOENIX_SECRET")
