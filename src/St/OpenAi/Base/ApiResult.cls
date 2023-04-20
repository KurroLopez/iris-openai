Class St.OpenAi.Base.ApiResult Extends (%RegisteredObject, %JSON.Adaptor)
{

/// The time when the result was generated
Property Created As %TimeStamp(%JSONINCLUDE = "none");

/// Override method to return UnixTime in Timestamp format
Method CreatedGet() As %TimeStamp
{
    if (..CreatedUnixTime > 0) 
    {
        return $ZDATETIMEH(..CreatedUnixTime,-2) 
    }
    else 
    {
        return $ZDATETIMEH(0,-2)
    }
}

/// The time when the model was created in unix epoch format
Property CreatedUnixTime As %Integer(%JSONFIELDNAME = "created");

/// Which model was used to generate this result.
Property Model As St.OpenAi.Model.Model(%JSONFIELDNAME = "model", XMLPROJECTION = "ELEMENT");

/// Object type, ie: text_completion, file, fine-tune, list, etc
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// The organization associated with the API request, as reported by the API.
Property Organization As %String(%JSONINCLUDE = "none", MAXLEN = "");

/// The server-side processing time as reported by the API.  This can be useful for debugging where a delay occurs.
Property ProcessingTime As %TimeStamp(%JSONINCLUDE = "none");

/// The request id of this API call, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property RequestId As %String(%JSONINCLUDE = "none", MAXLEN = "");

/// The Openai-Version used to generate this response, as reported in the response headers.  This may be useful for troubleshooting or when contacting OpenAI support in reference to a specific request.
Property OpenaiVersion As %String(%JSONINCLUDE = "none", MAXLEN = "");

}
