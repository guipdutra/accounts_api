defmodule AccountsApi.Repo do
  use Ecto.Repo,
    otp_app: :accounts_api,
    adapter: Ecto.Adapters.Postgres
end
