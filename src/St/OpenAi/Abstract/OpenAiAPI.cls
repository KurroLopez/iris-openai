Class St.OpenAi.Abstract.OpenAiAPI Extends %Library.RegisteredObject [ Abstract ]
{

/// Base url for OpenAI
/// for OpenAI, should be "{0}/{1}" (version/method)
Property ApiUrlFormat As %String(MAXLEN = "");

/// Version of Rest API
/// for OpenAI, should be "v1"
Property ApiVersion As %String;

/// Server name of OpenAI
/// for OpenAI, should be "api.openai.com"
Property ApiServer As %String(MAXLEN = "");

/// The API authentication information to use for API calls
Property Auth As St.OpenAi.Abstract.ApiAuthentication;

/// Optionally provide an %Net.HttpRequest to create the client to send requests.
Property HttpClientFactory As %Net.HttpRequest;

/// The API endpoint for querying available Engines/models
Property Models As St.OpenAi.Abstract.ModelsEndpoint;

/// Creates a new entry point to the OpenAPI API, handling auth and allowing access to the various API endpoints
Method %OnNew(auth As St.OpenAi.Abstract.ApiAuthentication, Output valid As %Status) As %Status
{
    Quit $$$ERROR($$$GeneralError, "%OnNew not implemented by " _ ..%ClassName(1))
}

}
