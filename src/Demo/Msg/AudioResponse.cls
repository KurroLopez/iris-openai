Class Demo.Msg.AudioResponse Extends (Ens.Response, %JSON.Adaptor)
{

Property Task As %String(%JSONFIELDNAME = "task", MAXLEN = "");

Property Language As %String(%JSONFIELDNAME = "language", MAXLEN = "");

Property Duration As %Decimal(%JSONFIELDNAME = "duration");

Property Text As %String(%JSONFIELDNAME = "text", MAXLEN = "");

Storage Default
{
<Data name="AudioResponseDefaultData">
<Subscript>"AudioResponse"</Subscript>
<Value name="1">
<Value>Task</Value>
</Value>
<Value name="2">
<Value>Language</Value>
</Value>
<Value name="3">
<Value>Duration</Value>
</Value>
<Value name="4">
<Value>Text</Value>
</Value>
</Data>
<DefaultData>AudioResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
