defmodule Elixible.XMPP.Mapper do
  alias Elixible.XMPP.Stanza.{JID, IQ, Bind, Chatstate, Message}

  def to_struct({:iq, id, type, lang, from, to, error, sub_els}) do
    %IQ{
      id: id, 
      type: type, 
      lang: lang, 
      from: to_struct(from), 
      to: to_struct(to), 
      error: error, 
      sub_els: Enum.map(sub_els, &to_struct/1)}
  end

  def to_struct({:chatstate, type}) do
    %Chatstate{type: type}
  end

  def to_struct({:message, id, type, lang, from, to , subject, body, thread, error, sub_els}) do
    %Message{
      id: id, 
      type: type, 
      lang: lang, 
      from: to_struct(from), 
      to: to_struct(to), 
      subject: subject,
      body: body,
      thread: thread,
      error: error,
      sub_els: Enum.map(sub_els, &to_struct/1)} 
  end

  def to_struct({:bind, jid, resource}) do
    %Bind{
      jid: jid, 
      resource: resource}
  end

  def to_struct({:jid, user, server, resource, luser, lserver, lresource}) do
    %JID{
      user: user,
      server: server,
      resource: resource,
      luser: luser,
      lserver: lserver,
      lresource: lresource}
  end

  def to_struct(record) do
    record
  end
end
