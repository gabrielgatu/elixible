defmodule Elixible.Client.Handler do
  use GenServer

  alias Elixible.{Client.Storage, Builder, Connection, Auth}

  # TODO: Check for errors on start_link and return correct value
  def start_link(jid, password) do
    {:ok, pid} = GenServer.start_link(__MODULE__, {jid, password})
    Storage.put(jid, pid)
  end

  def send_message(from, to, message) do
    Storage.get(from)
    |> GenServer.cast({:send_message, from, to, message})
  end

  # Server API

  def init({jid, password}) do
    {username, host} = decompose_jid(jid)

    {:ok, connection} = Connection.start_link(host)
    Auth.login(connection, username, password)

    {:ok, %{connection: connection, jid: jid, host: host}}
  end

  def handle_cast({:send_message, from, to, message}, %{connection: conn} = state) do
    {recipient_name, recipient_host} = decompose_jid(to)

    IO.puts "Sending message from #{from} to #{to}: #{message}"

    command = Builder.build_message(recipient_host, recipient_name, message)
    Connection.command(conn, command)
    {:noreply, state}
  end

  defp decompose_jid(jid) do
    [user, host] = String.split(jid, "@")
    host = String.to_char_list(host)
    {user, host}
  end
end
