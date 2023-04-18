Class St.OpenAi.OpenAiAPi Extends %Library.RegisteredObject
{

/// Base url for OpenAI
/// for OpenAI, should be "https://api.openai.com/{0}/{1}"
Property ApiUrlFormat As %String(MAXLEN = "");

/// Version of Rest API
Property ApiVersion As %String;

/// The API authentication information to use for API calls
Property Auth As ApiAuthentication;

/// Creates a new entry point to the OpenAPI API, handling auth and allowing access to the various API endpoints
Method %OnNew(auth As ApiAuthentication, Output valid As %Status) As %Status
{
    set valid = $$$OK

    set ..Auth = auth
    set valid = ..%ValidateObject() // validate the new object

    return $$$OK
}

}
