defmodule Elixible.Client.Handler do
  use GenServer

  alias Elixible.{Client.Storage, Builder, Connection, Auth}
  alias XmppMapper.Stanza

  # TODO: Check for errors on start_link and return correct value
  @doc """
  Given a jid and password, it starts a connection.
  """
  def start_link(jid, password) do
    {:ok, pid} = GenServer.start_link(__MODULE__, {jid, password})
    Storage.put(jid, pid)
  end

  @doc """
  Given a user, it returns the online users on the user host.
  """
  def online_users(from) do
    Storage.get(from)
    |> GenServer.cast({:online_users, from})
  end

  @doc """
  Send a message from a user to another.
  """
  def send_message(from, to, message) do
    Storage.get(from)
    |> GenServer.cast({:send_message, from, to, message})
  end

  @doc """
  Updates the user status.
  """
  def send_presence(from, status) do
    Storage.get(from)
    |> GenServer.cast({:send_presence, status})
  end

  @doc """
  PRIVATE.
  Handle response from socket. It parses and dispatches it correctly
  to the client.
  """
  def handle_response(xml) do
    case XmppMapper.Parser.parse(xml) do
      {:ok, stanza} -> dispatch(stanza)
      {:error, error} -> IO.puts "Error: #{inspect error}"
    end
  end

  defp dispatch(%Stanza.IQ{} = iq) do
    dispatch_on_client(:handle_iq, [iq])
  end

  defp dispatch(%Stanza.Message{} = message) do
    dispatch_on_client(:handle_message, [message])
  end

  defp dispatch(%Stanza.Chatstate{} = chatstate) do
    dispatch_on_client(:handle_chatstate, [chatstate])
  end

  defp dispatch(%Stanza.Presence{} = presence) do
    dispatch_on_client(:handle_presence, [presence])
  end

  defp dispatch(something) do
    IO.puts "DISPATCH NOT FOUND!"
    IO.inspect something
  end

  defp dispatch_on_client(func_name, opts) do
    mod = Application.get_env(:elixible, :client)
    apply(mod, func_name, opts)
  end

  # Server API

  def init({jid, password}) do
    jid = Stanza.JID.from_string(jid)
    username = jid.user
    host = jid.server

    {:ok, connection} = Connection.start_link(host)
    Auth.login(connection, username, password)

    {:ok, %{connection: connection, jid: jid, host: host}}
  end

  def handle_cast({:online_users, from}, %{connection: conn} = state) do
    server = Stanza.JID.from_string(from) |> Map.get(:server)

    command = Builder.online_users(server) |> IO.inspect
    Connection.command(conn, command)
    {:noreply, state}
  end

  def handle_cast({:send_message, _from, to, message}, %{connection: conn} = state) do
    to = Stanza.JID.from_string(to)
    recipient_name = to.user
    recipient_host = to.server

    command = Builder.build_message(recipient_host, recipient_name, message)
    Connection.command(conn, command)
    {:noreply, state}
  end

  def handle_cast({:send_presence, status}, %{connection: conn} = state) do
    command = Builder.build_presence(status)
    Connection.command(conn, command)
    {:noreply, state}
  end
end
