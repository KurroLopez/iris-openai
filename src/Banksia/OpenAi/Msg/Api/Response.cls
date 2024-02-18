Class Banksia.OpenAi.Msg.Api.Response Extends (Ens.Response, %JSON.Adaptor, %XML.Adaptor)
{

/// The time when the model was created in unix epoch format
Property Created As %Integer(%JSONFIELDNAME = "created");

/// Which model was used to generate this result.
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "");

/// Object type, ie: text_completion, file, fine-tune, list, etc
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// The organization associated with the API request, as reported by the API.
Property Organization As %String(%JSONINCLUDE = "none", MAXLEN = "");

/// The request id of this API call, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property RequestId As %String(%JSONINCLUDE = "none", MAXLEN = "");

/// The Openai-Version used to generate this response, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property OpenaiVersion As %String(%JSONINCLUDE = "none", MAXLEN = "");

Storage Default
{
<Data name="ResponseDefaultData">
<Subscript>"Response"</Subscript>
<Value name="1">
<Value>Created</Value>
</Value>
<Value name="2">
<Value>Model</Value>
</Value>
<Value name="3">
<Value>Object</Value>
</Value>
<Value name="4">
<Value>Organization</Value>
</Value>
<Value name="5">
<Value>RequestId</Value>
</Value>
<Value name="6">
<Value>OpenaiVersion</Value>
</Value>
</Data>
<DefaultData>ResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
