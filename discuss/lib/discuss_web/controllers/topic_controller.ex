defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end
end
