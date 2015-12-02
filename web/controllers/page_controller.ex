defmodule JsonapiOverhaul.PageController do
  use JsonapiOverhaul.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
