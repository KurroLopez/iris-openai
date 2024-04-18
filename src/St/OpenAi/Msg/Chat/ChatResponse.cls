Class St.OpenAi.Msg.Chat.ChatResponse Extends St.OpenAi.Msg.Api.Response
{

/// The identifier of the result, which may be used during troubleshooting
Property Id As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// The list of choices that the user was presented with during the chat interaction
Property Choices As list Of St.OpenAi.Msg.Chat.ChatChoice(%JSONFIELDNAME = "choices", XMLPROJECTION = "ELEMENT");

/// The usage statistics for the chat interaction
Property Usage As St.OpenAi.Msg.Chat.ChatUsage(%JSONFIELDNAME = "usage", XMLPROJECTION = "ELEMENT");

/// This fingerprint represents the backend configuration that the model runs with.
Property SystemFingerprint As %String(%JSONFIELDNAME = "system_fingerprint", MAXLEN = "");

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
<Value name="4">
<Value>SystemFingerprint</Value>
</Value>
</Data>
<DefaultData>ChatResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
