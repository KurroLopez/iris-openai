Class St.OpenAi.Msg.Base.Usage Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// How many tokens did the prompt consist of
Property PromptTokens As %Integer(%JSONFIELDNAME = "prompt_tokens");

/// How many tokens did the request consume total
Property TotalTokens As %Integer(%JSONFIELDNAME = "total_tokens");

Storage Default
{
<Data name="UsageState">
<Value name="1">
<Value>PromptTokens</Value>
</Value>
<Value name="2">
<Value>TotalTokens</Value>
</Value>
</Data>
<State>UsageState</State>
<StreamLocation>^St.OpenAi.Msg.Base.UsageS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
