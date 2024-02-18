Class Banksia.OpenAi.Msg.Model.Request Extends Ens.Request
{

/// Model Id
Property Model As %String(MAXLEN = "");

Storage Default
{
<Data name="ModelRequestDefaultData">
<Subscript>"ModelRequest"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
</Data>
<DefaultData>ModelRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
