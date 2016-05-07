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
    |> complete_missing_namespaces
    |> :xmpp_codec.decode
    |> Elixible.XMPP.Mapper.to_struct
  end

  defp complete_missing_namespaces({:xmlel, name, attrs, children}) do
    {:xmlel, name, attrs, Enum.map(children, &add_missing_namespaces/1)}
    |> add_missing_namespaces
  end

  def add_missing_namespaces({:xmlel, _name, [{"xmlns", "jabber:client"} | _attrs], _children} = xml) do
    xml
  end

  def add_missing_namespaces({:xmlel, name, [{"xmlns", _} | attrs], children} = xml) do
    add_missing_namespaces({:xmlel, name, attrs, children})
  end

  def add_missing_namespaces({:xmlel, name, attrs, children}) do
    attrs = [{"xmlns", "jabber:client"} | attrs]
    {:xmlel, name, attrs, children}
  end
end
