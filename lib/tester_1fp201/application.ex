defmodule Tester1fp201.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Tester1fp201Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tester1fp201.PubSub},
      # Start the Endpoint (http/https)
      Tester1fp201Web.Endpoint
      # Start a worker by calling: Tester1fp201.Worker.start_link(arg)
      # {Tester1fp201.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tester1fp201.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Tester1fp201Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
