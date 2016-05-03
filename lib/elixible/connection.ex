defmodule Elixible.Connection do
  use GenServer

  # TODO: Implement Connection lib

  def start_link(host, port \\ 5222) when is_list(host) and is_integer(port) do
    GenServer.start_link __MODULE__, {host, port}
  end

  def command(pid, command) do
    GenServer.cast(pid, {:command, command})
  end

  # Server API

  def init({host, port}) do
    {:ok, socket} = :gen_tcp.connect host, port, [:binary, active: true]
    {:ok, %{socket: socket, host: host}}
  end

  def handle_cast({:command, command}, %{socket: socket} = state) do
    :gen_tcp.send socket, command
    {:noreply, state}
  end

  def handle_info({:tcp, socket, msg}, state) do
    handle_xmpp_message(msg)
    {:noreply, state}
  end

  # TODO: Extract from, to and message (parsing xml)
  defp handle_xmpp_message("<message" <> _tail = message) do
    apply(Sample.Client, :handle_message, [nil, nil, message])
  end

  defp handle_xmpp_message(_msg) do
  end
end
