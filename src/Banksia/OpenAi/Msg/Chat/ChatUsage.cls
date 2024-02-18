Class Banksia.OpenAi.Msg.Chat.ChatUsage Extends Banksia.OpenAi.Msg.Base.Usage
{

/// The number of completion tokens used during the chat interaction
Property CompletionTokens As %Integer(%JSONFIELDNAME = "completion_tokens");

Storage Default
{
<Data name="UsageState">
<Value name="1">
<Value>PromptTokens</Value>
</Value>
<Value name="2">
<Value>TotalTokens</Value>
</Value>
<Value name="3">
<Value>CompletionTokens</Value>
</Value>
</Data>
<Type>%Storage.Serial</Type>
}

}
