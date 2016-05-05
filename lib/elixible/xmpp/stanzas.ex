defmodule Elixible.XMPP.Stanza do

  defmodule JID do
    defstruct user: nil, server: nil, resource: nil, luser: nil, lserver: nil, lresource: nil

    # Watch inside jid.erl for the implementation adopted or 
    # just convert to a tuple and use :jid.to_string
    def jid(%JID{user: user, server: server, resource: res} = jid) do
      "#{user}@#{server}"
    end
  end

  defmodule IQ do
    defstruct id: nil, type: nil, lang: nil, from: nil, to: nil, 
      error: nil, sub_els: nil
  end

  defmodule Bind do
    defstruct jid: nil, resource: nil
  end

  defmodule Chatstate do
    defstruct type: nil
  end

  defmodule Message do
    defstruct id: nil, type: nil, lang: nil, from: nil, to: nil, subject: nil,
      body: nil, thread: nil, error: nil, sub_els: nil
  end
end
