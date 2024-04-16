defmodule AccountsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AccountsApiWeb.Telemetry,
      AccountsApi.Repo,
      {DNSCluster, query: Application.get_env(:accounts_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AccountsApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AccountsApi.Finch},
      # Start a worker by calling: AccountsApi.Worker.start_link(arg)
      # {AccountsApi.Worker, arg},
      # Start to serve requests, typically the last entry
      AccountsApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AccountsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AccountsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
