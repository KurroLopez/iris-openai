Class Banksia.OpenAi.Msg.SimplePrompt.Response Extends Banksia.OpenAi.Msg.Api.Response
{

/// The content of the message
Property Content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

/// The usage statistics for the chat interaction
Property Usage As Banksia.OpenAi.Msg.Chat.Usage(%JSONFIELDNAME = "usage", XMLPROJECTION = "ELEMENT");

Storage Default
{
<Data name="ResponseDefaultData1">
<Subscript>"Response1"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>Usage</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData1</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
