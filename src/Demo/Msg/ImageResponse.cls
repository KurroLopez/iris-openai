Class Demo.Msg.ImageResponse Extends (Ens.Response, %JSON.Adaptor)
{

/// List of images required
Property Data As list Of %String(%JSONFIELDNAME = "data", MAXLEN = "");

Storage Default
{
<Data name="ImageResponseDefaultData">
<Subscript>"ImageResponse"</Subscript>
<Value name="1">
<Value>Data</Value>
</Value>
</Data>
<DefaultData>ImageResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
