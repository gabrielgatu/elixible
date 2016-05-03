defmodule Elixible.Auth do

  alias Elixible.Auth.{Plain}

  def login(conn, username, password) do
    Plain.login(conn, username, password)
  end
end
