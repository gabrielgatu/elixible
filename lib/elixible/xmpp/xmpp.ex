defmodule Elixible.XMPP do

  def parse(xml) do
    xml
    |> :fxml_stream.parse_element
    |> handle_parse_result
  end

  defp handle_parse_result({:error, _} = xml) do
    # IO.inspect xml
  end

  defp handle_parse_result({:xmlel, "success", _, _} = xml) do
    # IO.inspect xml
  end

  defp handle_parse_result(msg) do
    msg
    |> add_xmlns_if_not_present
    |> :xmpp_codec.decode
    |> Elixible.XMPP.Mapper.to_struct
  end

  defp add_xmlns_if_not_present({:xmlel, _name, [{"xmlns", "jabber:client"} | _], _opts} = xml) do
    xml
  end

  defp add_xmlns_if_not_present({:xmlel, name, attrs, opts}) do
    attrs = [{"xmlns", "jabber:client"} | attrs]
    {:xmlel, name, attrs, opts}
  end
end
