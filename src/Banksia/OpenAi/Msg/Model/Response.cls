Class Banksia.OpenAi.Msg.Model.Response Extends Banksia.OpenAi.Msg.Api.Response
{

Property ModelObject As Banksia.OpenAi.Msg.Model.Model;

/// Model
Storage Default
{
<Data name="ModelResponseDefaultData">
<Subscript>"ModelResponse"</Subscript>
<Value name="1">
<Value>ModelObject</Value>
</Value>
</Data>
<DefaultData>ModelResponseDefaultData</DefaultData>
<Description>
<![CDATA[Model]]></Description>
<Type>%Storage.Persistent</Type>
}

}
