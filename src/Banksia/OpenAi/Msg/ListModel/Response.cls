Class Banksia.OpenAi.Msg.ListModel.Response Extends Banksia.OpenAi.Msg.Api.Response
{

Property Data As list Of Banksia.OpenAi.Msg.Model.Model(%JSONFIELDNAME = "data", XMLPROJECTION = "ELEMENT");

/// List of models
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
