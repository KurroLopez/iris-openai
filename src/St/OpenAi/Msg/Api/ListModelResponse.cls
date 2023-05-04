Class St.OpenAi.Msg.Api.ListModelResponse Extends St.OpenAi.Msg.Api.Response
{

/// List of models
Property Data As list Of St.OpenAi.Msg.Model.Model(%JSONFIELDNAME = "data", XMLPROJECTION = "ELEMENT");

/// Object
Property Obj As %String(%JSONFIELDNAME = "object", MAXLEN = "");

Storage Default
{
<Data name="ListModelResponseDefaultData">
<Subscript>"ListModelResponse"</Subscript>
<Value name="1">
<Value>Data</Value>
</Value>
<Value name="2">
<Value>Obj</Value>
</Value>
</Data>
<DefaultData>ListModelResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
