defmodule Sample.Client do
  use Elixible.Client

  # TODO: config :elixible, Sample.Client

  def handle_login(jid) do
    IO.puts "#{jid} logged in."
  end

  def handle_message(from, to, message) do
    IO.puts "Received message!"
    IO.inspect message

    # TODO: Not working because the first 2 fields are nil,
    # needs parsing in connection.ex
    # send_message(to, from, "Received message!")
  end

  # handle_presence
  # handle_iq
  # handle_info
end
