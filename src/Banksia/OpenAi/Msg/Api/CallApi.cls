Class Banksia.OpenAi.Msg.Api.CallApi Extends %SerialObject
{

/// Content of api request
Property Content As %Library.DynamicObject;

/// The organization associated with the API request, as reported by the API.
Property Organization As %String(MAXLEN = "");

/// The request id of this API call, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property RequestId As %String(MAXLEN = "");

/// The Openai-Version used to generate this response, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property OpenaiVersion As %String(MAXLEN = "");

Storage Default
{
<Data name="CallApiState">
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>Organization</Value>
</Value>
<Value name="3">
<Value>RequestId</Value>
</Value>
<Value name="4">
<Value>OpenaiVersion</Value>
</Value>
</Data>
<State>CallApiState</State>
<StreamLocation>^Banksia.OpenAi.Msg.Api.CallApiS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
