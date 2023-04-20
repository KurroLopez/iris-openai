Class St.OpenAi.Abstract.OpenAiAPI Extends %Library.RegisteredObject [ Abstract ]
{

/// Base url for OpenAI
/// for OpenAI, should be "https://api.openai.com/{0}/{1}"
Property ApiUrlFormat As %String(MAXLEN = "");

/// Version of Rest API
Property ApiVersion As %String;

/// The API authentication information to use for API calls
Property Auth As St.OpenAi.Abstract.ApiAuthentication;

/// The API endpoint for querying available Engines/models
Property Models As St.OpenAi.Abstract.ModelsEndpoint;

/// Creates a new entry point to the OpenAPI API, handling auth and allowing access to the various API endpoints
Method %OnNew(auth As St.OpenAi.Abstract.ApiAuthentication, Output valid As %Status) As %Status
{
    Quit $$$ERROR($$$GeneralError, "%OnNew not implemented by " _ ..%ClassName(1))
}

}
