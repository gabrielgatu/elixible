defmodule Elixible.Auth do

  alias Elixible.Auth.{Plain}

  # TODO: Add resource option with default
  def login(conn, username, password) do
    Plain.login(conn, username, password)
  end
end
