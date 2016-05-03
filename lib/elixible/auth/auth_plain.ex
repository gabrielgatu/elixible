defmodule Elixible.Auth.Plain do

  alias Elixible.{Builder, Connection}

  # TODO: Find a way to block in a efficent way - Needs to block always?
  def login(conn, username, password) do
    open_jabber_connection(conn)
    :timer.sleep(300)

    do_login(conn, username, password)
    :timer.sleep(300)

    bind_resource(conn, username)
    :timer.sleep(300)
  end

  defp open_jabber_connection(conn) do
    command = Builder.start_stream
    Connection.command(conn, command)
  end

  defp do_login(conn, username, password) do
    command = Builder.login(username, password)
    Connection.command(conn, command)
  end

  defp bind_resource(conn, username) do
    command = Builder.start_stream
    Connection.command(conn, command)

    command = Builder.bind_resource(username)
    Connection.command(conn, command)

    command = Builder.set_session_id(1)
    Connection.command(conn, command)
  end
end
