Class Demo.Msg.ChatRequest Extends (Ens.Request, %JSON.Adaptor)
{

Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

Property MaxTokens As %Integer(%JSONFIELDNAME = "max_tokens");

Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "");

Storage Default
{
<Data name="ChatRequestDefaultData">
<Subscript>"ChatRequest"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
<Value name="2">
<Value>MaxTokens</Value>
</Value>
<Value name="3">
<Value>Model</Value>
</Value>
</Data>
<DefaultData>ChatRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
