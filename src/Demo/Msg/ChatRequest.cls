Class Demo.Msg.ChatRequest Extends (Ens.Request, %JSON.Adaptor)
{

Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

Storage Default
{
<Data name="ChatRequestDefaultData">
<Subscript>"ChatRequest"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
</Data>
<DefaultData>ChatRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
