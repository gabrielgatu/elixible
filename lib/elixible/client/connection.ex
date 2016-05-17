defmodule Elixible.Connection do
  use GenServer

  def start_link(host, port \\ 5222) when is_bitstring(host) and is_integer(port) do
    host = String.to_char_list(host)
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

  def handle_info({:tcp, _socket, xml}, state) do
    Elixible.Client.Handler.handle_response(xml)
    {:noreply, state}
  end
end
