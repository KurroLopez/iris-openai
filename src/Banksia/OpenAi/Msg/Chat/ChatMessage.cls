Class Banksia.OpenAi.Msg.Chat.ChatMessage Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// The role of the message, which can be "system", "assistant" or "user"
Property Role As %String(%JSONFIELDNAME = "role", VALUELIST = ",system,user,assistant");

/// The content of the message
Property Content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

/// An optional name of the user in a multi-user chat 
Property Name As %String(%JSONFIELDNAME = "name", MAXLEN = "");

Storage Default
{
<Data name="ChatMessageState">
<Value name="1">
<Value>Role</Value>
</Value>
<Value name="2">
<Value>Content</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
</Data>
<State>ChatMessageState</State>
<StreamLocation>^Banksia.OpenAi.Msg180C.ChatMessageS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
