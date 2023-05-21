Class St.OpenAi.Msg.Model.ModelResponse Extends St.OpenAi.Msg.Api.Response
{

/// Model
Property ModelObject As St.OpenAi.Msg.Model.Model;

Storage Default
{
<Data name="ModelResponseDefaultData">
<Subscript>"ModelResponse"</Subscript>
<Value name="1">
<Value>ModelObject</Value>
</Value>
</Data>
<DefaultData>ModelResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
