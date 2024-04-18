Class Demo.Msg.ModerationResponse Extends (Ens.Response, %JSON.Adaptor)
{

/// Description
Property Description As %String(%JSONFIELDNAME = "description", MAXLEN = "");

Storage Default
{
<Data name="ModerationResponseDefaultData">
<Subscript>"ModerationResponse"</Subscript>
<Value name="1">
<Value>Description</Value>
</Value>
</Data>
<DefaultData>ModerationResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
