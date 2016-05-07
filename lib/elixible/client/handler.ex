defmodule Elixible.Client.Handler do
  use GenServer

  alias Elixible.{XMPP.Stanza, Client.Storage, Builder, Connection, Auth}

  # TODO: Check for errors on start_link and return correct value
  def start_link(jid, password) do
    {:ok, pid} = GenServer.start_link(__MODULE__, {jid, password})
    Storage.put(jid, pid)
  end

  def send_message(from, to, message) do
    Storage.get(from)
    |> GenServer.cast({:send_message, from, to, message})
  end

  def send_presence(from, status) do
    Storage.get(from)
    |> GenServer.cast({:send_presence, status})
  end

  def dispatch(%Stanza.IQ{} = iq) do
    Sample.Client.handle_iq(iq)
  end

  def dispatch(%Stanza.Message{} = message) do
    Sample.Client.handle_message(message) 
  end

  def dispatch(%Stanza.Chatstate{} = chatstate) do
    Sample.Client.handle_chatstate(chatstate)
  end
  
  def dispatch(%Stanza.Presence{} = presence) do
    Sample.Client.handle_presence(presence)
  end

  def dispatch(something) do
    IO.puts "DISPATCH NOT FOUND!"
    IO.inspect something
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

  def handle_cast({:send_presence, status}, %{connection: conn} = state) do
    command = Builder.build_presence(status)
    Connection.command(conn, command)
    {:noreply, state}
  end

  defp decompose_jid(jid) do
    [user, host] = String.split(jid, "@")
    host = String.to_char_list(host)
    {user, host}
  end
end
