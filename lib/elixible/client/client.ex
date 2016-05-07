defmodule Elixible.Client do
  alias Elixible.Client.Handler

  defmacro __using__(_opts) do
    quote do
      unquote(delegates())
    end
  end

  def delegates do
    quote do
      defdelegate login(jid, password), to: Elixible.Client
      defdelegate send_message(from, to, message), to: Elixible.Client
      defdelegate send_presence(from, status), to: Elixible.Client
    end
  end

  @spec send_presence(String.t, String.t)
  def login(jid, password) do
    Handler.start_link(jid, password)
  end

  @spec send_presence(String.t, String.t)
  def send_message(from, to, message) when is_binary(from) and is_binary(to) do
    Handler.send_message(from, to, message)
  end

  # TODO: Add Elixible.XMPP.Stanza.JID.t and write spec
  def send_message(from, to, message) do
    from = Elixible.XMPP.Stanza.JID.jid(from)
    to = Elixible.XMPP.Stanza.JID.jid(to)
    send_message(from, to, message)
  end

  @spec send_presence(String.t, String.t)
  def send_presence(from, status) do
    Handler.send_presence(from, status)
  end
end

