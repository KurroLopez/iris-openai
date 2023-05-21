Class Demo.Msg.ChatResponse Extends (Ens.Response, %JSON.Adaptor)
{

Property Content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

Storage Default
{
<Data name="ChatResponseDefaultData">
<Subscript>"ChatResponse"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
</Data>
<DefaultData>ChatResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
