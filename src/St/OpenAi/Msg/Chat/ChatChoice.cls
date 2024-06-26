Class St.OpenAi.Msg.Chat.ChatChoice Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// The index of the choice in the list of choices
Property Index As %Integer(%JSONFIELDNAME = "index");

/// The message that was presented to the user as the choice
Property Message As ChatMessage(%JSONFIELDNAME = "message", XMLPROJECTION = "ELEMENT");

/// The reason why the chat interaction ended after this choice was presented to the user
Property FinishReason As %String(%JSONFIELDNAME = "finish_reason", MAXLEN = "");

/// Partial message "delta" from a stream. For example, the result from StreamChatEnumerableAsync.
/// If this result object is not from a stream, this will be null
Property Delta As ChatMessage(%JSONFIELDNAME = "delta", XMLPROJECTION = "ELEMENT");

/// Whether to return log probabilities of the output tokens or not. 
/// If true, returns the log probabilities of each output token returned in the content of message. 
/// This option is currently not available on the gpt-4-vision-preview model.
Property LogProbs As %Boolean(%JSONFIELDNAME = "logprobs");

Storage Default
{
<Data name="ChatChoiceState">
<Value name="1">
<Value>Index</Value>
</Value>
<Value name="2">
<Value>Message</Value>
</Value>
<Value name="3">
<Value>FinishReason</Value>
</Value>
<Value name="4">
<Value>Delta</Value>
</Value>
<Value name="5">
<Value>LogProbs</Value>
</Value>
</Data>
<State>ChatChoiceState</State>
<StreamLocation>^St.OpenAi.Msg.Chat.ChatChoiceS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
