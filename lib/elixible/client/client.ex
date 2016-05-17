defmodule Elixible.Client do
  alias Elixible.Client.Handler

  alias XmppMapper.Stanza.{JID}

  defmacro __using__(_opts) do
    quote do
      unquote(delegates())
    end
  end

  defp delegates do
    quote do
      defdelegate login(jid, password), to: Elixible.Client
      defdelegate online_users(from), to: Elixible.Client
      defdelegate send_message(from, to, message), to: Elixible.Client
      defdelegate send_presence(from, status), to: Elixible.Client
    end
  end

  @doc """
  Login with the given jid and password.
  """
  @spec login(String.t, String.t) :: none()
  def login(jid, password) do
    Handler.start_link(jid, password)
  end

  @doc """
  Returns the online users on the same host of the user.
  """
  def online_users(from) do
    Handler.online_users(from)
  end

  @doc """
  Sends a message to another user.
  """
  @spec send_message(String.t, String.t, String.t) :: none()
  def send_message(from, to, message) when is_binary(from) and is_binary(to) do
    Handler.send_message(from, to, message)
  end

  @spec send_message(%JID{}, %JID{}, String.t) :: none()
  def send_message(%JID{} = from, %JID{} = to, message) do
    from = JID.to_string(from)
    to = JID.to_string(to)
    send_message(from, to, message)
  end

  @doc """
  Updates the user status.
  """
  @spec send_presence(String.t, String.t) :: none()
  def send_presence(from, status) do
    Handler.send_presence(from, status)
  end
end
