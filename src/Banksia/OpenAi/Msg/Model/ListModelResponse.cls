Class Banksia.OpenAi.Msg.Model.ListModelResponse Extends Banksia.OpenAi.Msg.Api.Response
{

/// List of models
Property Data As list Of Banksia.OpenAi.Msg.Model.Model(%JSONFIELDNAME = "data", XMLPROJECTION = "ELEMENT");

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
