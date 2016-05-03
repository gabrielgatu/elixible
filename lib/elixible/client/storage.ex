defmodule Elixible.Client.Storage do
  @name __MODULE__
  
  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def put(jid, pid) do
    Agent.update(@name, &Map.put(&1, jid, pid))
  end

  def get(jid) do
    Agent.get(@name, &Map.get(&1, jid))
    |> case do
      nil -> IO.puts "Error, jid not found!"
      pid -> pid
    end
  end
end
