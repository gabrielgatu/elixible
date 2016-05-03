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
    end
  end

  def login(jid, password) do
    Handler.start_link(jid, password)
  end

  def send_message(from, to, message) do
    Handler.send_message(from, to, message)
  end
end

