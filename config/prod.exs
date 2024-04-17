import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: AccountsApi.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Finally import the config/prod.secret.exs
# which should be versioned separately.
# import_config "prod.secret.exs"
config :accounts_api, AccountsApiWeb.Endpoint,
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
  server: true

config :accounts_api, AccountsApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  ssl: true,
  ssl_opts: [verify: :verify_none],
  pool_size: 2 # Free tier db only allows 1 connection
