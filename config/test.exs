use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jsonapi_overhaul, JsonapiOverhaul.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :jsonapi_overhaul, JsonapiOverhaul.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "jsonapi_overhaul_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
