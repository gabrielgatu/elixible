defmodule Elixible.Builder do

  def build_message(host, user, message) do
    "<message id='fbfb9ce5-7f3b-489a-9aef-f25691960233' to='#{user}@#{host}' type='chat'><body>#{message}</body></message>"
  end

  def login(username, password) do
    hashed_credentials = Base.encode64("\0#{username}\0#{password}")
    "<auth xmlns='urn:ietf:params:xml:ns:xmpp-sasl' mechanism='PLAIN'>#{hashed_credentials}</auth>"
  end

  def bind_resource(res_name) do
    "<iq type='set' id='0'>
      <bind xmlns='urn:ietf:params:xml:ns:xmpp-bind'>
        <resource>#{res_name}</resource>
      </bind>
    </iq>"
  end

  def set_session_id(id) do
    "<iq type='set' id='#{id}'><session xmlns='urn:ietf:params:xml:ns:xmpp-session'/></iq>"
  end

  def start_stream do
    "<stream:stream to='localhost' xmlns='jabber:client' xmlns:stream='http://etherx.jabber.org/streams' version='1.0'>"
  end
end
