defmodule Scramble.Repo do
  use Ecto.Repo,
    otp_app: :scramble,
    adapter: Ecto.Adapters.Postgres
end
