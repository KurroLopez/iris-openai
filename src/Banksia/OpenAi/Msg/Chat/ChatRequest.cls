Class Banksia.OpenAi.Msg.Chat.ChatRequest Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

/// The model to use for this request
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "");

/// The messages to send with this Chat Request
Property Messages As list Of Banksia.OpenAi.Msg.Chat.ChatMessage(%JSONFIELDNAME = "messages", XMLPROJECTION = "ELEMENT");

/// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) 
/// for ones with a well-defined answer. It is generally recommend to use this or TopP but not both.
Property Temperature As %Double(%JSONFIELDNAME = "temperature");

/// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens 
/// with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. 
/// It is generally recommend to use this or Temperature but not both.
Property TopP As %Double(%JSONFIELDNAME = "top_p");

/// How many different choices to request for each message. Defaults to 1.
Property NumChoicesPerMessage As %Integer(%JSONFIELDNAME = "n");

/// Specifies where the results should stream and be returned at one time.
/// Do not set this yourself, use the appropriate methods on CompletionEndpoint instead.
Property Stream As %Boolean(%JSONFIELDNAME = "stream");

/// This is only used for serializing the request into JSON, do not use it directly.
Property CompiledStop As %ListOfDataTypes(%JSONFIELDNAME = "stop", XMLPROJECTION = "ELEMENT");

/// How many tokens to complete to. Can return fewer if a stop sequence is hit.  Defaults to 16.
Property MaxTokens As %Integer(%JSONFIELDNAME = "max_tokens");

/// The scale of the penalty for how often a token is used.  Should generally be between 0 and 1, 
/// although negative numbers are allowed to encourage token reuse.  Defaults to 0.
Property FrequencyPenalty As %Double(%JSONFIELDNAME = "frequency_penalty");

/// The scale of the penalty applied if a token is already present at all.  Should generally be between 0 and 1, although negative numbers are allowed to encourage token reuse.  Defaults to 0.
Property PresencePenalty As %Double(%JSONFIELDNAME = "presence_penalty");

/// Modify the likelihood of specified tokens appearing in the completion.
/// Accepts a json object that maps tokens(specified by their token ID in the tokenizer) to an associated bias value from -100 to 100.
/// Mathematically, the bias is added to the logits generated by the model prior to sampling.
/// The exact effect will vary per model, but values between -1 and 1 should decrease or increase likelihood of selection; values like -100 or 100 should result in a ban or exclusive selection of the relevant token.
Property LogitBias As %ArrayOfDataTypes(%JSONFIELDNAME = "logit_bias");

/// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
Property User As %String(%JSONFIELDNAME = "user", MAXLEN = "");

Storage Default
{
<Data name="ChatRequestDefaultData">
<Subscript>"ChatRequest"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>Messages</Value>
</Value>
<Value name="3">
<Value>Temperature</Value>
</Value>
<Value name="4">
<Value>TopP</Value>
</Value>
<Value name="5">
<Value>NumChoicesPerMessage</Value>
</Value>
<Value name="6">
<Value>Stream</Value>
</Value>
<Value name="7">
<Value>CompiledStop</Value>
</Value>
<Value name="8">
<Value>MaxTokens</Value>
</Value>
<Value name="9">
<Value>FrequencyPenalty</Value>
</Value>
<Value name="10">
<Value>PresencePenalty</Value>
</Value>
<Value name="11">
<Value>LogitBias</Value>
</Value>
<Value name="12">
<Value>User</Value>
</Value>
</Data>
<DefaultData>ChatRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}