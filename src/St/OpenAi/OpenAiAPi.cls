Class St.OpenAi.OpenAiAPI Extends St.OpenAi.Abstract.OpenAiAPI
{

/// Initialize Url Format
Property ApiUrlFormat As %String [ InitialExpression = "https://api.openai.com/%1/%2" ];

/// Initialize Version
Property ApiVersion As %String [ InitialExpression = "v1" ];

/// Creates a new entry point to the OpenAPI API, handling auth and allowing access to the various API endpoints
Method %OnNew(auth As St.OpenAi.Abstract.ApiAuthentication, Output valid As %Status) As %Status
{
    set valid = $$$OK

    set ..Auth = auth
    set api = ..%ConstructClone()
    set ..Models = ##class(St.OpenAi.Model.ModelsEndpoint).%New(api)
    set valid = ..%ValidateObject() // validate the new object

    return $$$OK
}

}
