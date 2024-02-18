Class Banksia.OpenAi.Msg.Model.ModelResponse Extends Banksia.OpenAi.Msg.Api.Response
{

/// Model
Property ModelObject As Banksia.OpenAi.Msg.Model.Model;

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
