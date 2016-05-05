defmodule Sample.Client do
  use Elixible.Client

  # TODO: config :elixible, Sample.Client
  # TODO: If the user doesn't implement a handle/1 func, then don't throw an excep. Just handle it.

  def handle_iq(iq) do
    IO.inspect iq
  end

  def handle_chatstate(chatstate) do
    IO.inspect chatstate
  end

  def handle_message(message) do
    IO.inspect message

    # from = Elixible.XMPP.Stanza.JID.jid(message.from)
    # to = Elixible.XMPP.Stanza.JID.jid(message.to)
    # Elixible.Client.send_message(to, from, "Received message!")
  end

  # handle_presence
  # handle_iq
  # handle_info
end
