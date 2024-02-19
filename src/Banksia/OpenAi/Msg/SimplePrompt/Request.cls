Class Banksia.OpenAi.Msg.SimplePrompt.Request Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

Parameter %JSONIGNOREINVALIDFIELD = 1;

/// The model to use for this request
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "");

/// Prompt which tells OpenAI chatbot what to do
Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

/// User Input which OpenAI chatbot will interpret based on prompt.
Property UserInput As %String(%JSONFIELDNAME = "user_input", MAXLEN = "");

/// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) 
/// for ones with a well-defined answer. It is generally recommend to use this or TopP but not both.
Property Temperature As %Double(%JSONFIELDNAME = "temperature");

/// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens 
/// with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. 
/// It is generally recommend to use this or Temperature but not both.
Property TopP As %Double(%JSONFIELDNAME = "top_p");

/// How many tokens to complete to. Can return fewer if a stop sequence is hit.  Defaults to 16.
Property MaxTokens As %Integer(%JSONFIELDNAME = "max_tokens");

/// The scale of the penalty for how often a token is used.  Should generally be between 0 and 1, 
/// although negative numbers are allowed to encourage token reuse.  Defaults to 0.
Property FrequencyPenalty As %Double(%JSONFIELDNAME = "frequency_penalty");

/// The scale of the penalty applied if a token is already present at all.  Should generally be between 0 and 1, although negative numbers are allowed to encourage token reuse.  Defaults to 0.
Property PresencePenalty As %Double(%JSONFIELDNAME = "presence_penalty");

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>Prompt</Value>
</Value>
<Value name="3">
<Value>UserInput</Value>
</Value>
<Value name="4">
<Value>Temperature</Value>
</Value>
<Value name="5">
<Value>TopP</Value>
</Value>
<Value name="6">
<Value>MaxTokens</Value>
</Value>
<Value name="7">
<Value>FrequencyPenalty</Value>
</Value>
<Value name="8">
<Value>PresencePenalty</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
