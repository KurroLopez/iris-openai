Class Banksia.OpenAi.Msg.Chat.Response Extends Banksia.OpenAi.Msg.Api.Response
{

/// The identifier of the result, which may be used during troubleshooting
Property Id As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// The list of choices that the user was presented with during the chat interaction
Property Choices As list Of Banksia.OpenAi.Msg.Chat.Choice(%JSONFIELDNAME = "choices", XMLPROJECTION = "ELEMENT");

/// The usage statistics for the chat interaction
Property Usage As Banksia.OpenAi.Msg.Chat.Usage(%JSONFIELDNAME = "usage", XMLPROJECTION = "ELEMENT");

Storage Default
{
<Data name="ChatResponseDefaultData">
<Subscript>"ChatResponse"</Subscript>
<Value name="1">
<Value>Id</Value>
</Value>
<Value name="2">
<Value>Choices</Value>
</Value>
<Value name="3">
<Value>Usage</Value>
</Value>
</Data>
<DefaultData>ChatResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
