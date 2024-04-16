Class Demo.Msg.ModerationRequest Extends (Ens.Request, %JSON.Adaptor)
{

/// The text to moderate
Property Prompt As %String(%JSONFIELDNAME = "input", MAXLEN = 4096) [ Required ];

Storage Default
{
<Data name="ModerationRequestDefaultData">
<Subscript>"ModerationRequest"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
</Data>
<DefaultData>ModerationRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
