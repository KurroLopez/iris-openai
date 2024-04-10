Class Demo.Msg.SpeachResponse Extends (Ens.Response, %JSON.Adaptor)
{

/// Data of the voice file
Property Data As %String(%JSONFIELDNAME = "data", MAXLEN = "");

/// The format to audio out.
Property ResponseFormat As %String(%JSONFIELDNAME = "response_format");

Storage Default
{
<Data name="SpeachResponseDefaultData">
<Subscript>"SpeachResponse"</Subscript>
<Value name="1">
<Value>Data</Value>
</Value>
<Value name="2">
<Value>ResponseFormat</Value>
</Value>
</Data>
<DefaultData>SpeachResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
