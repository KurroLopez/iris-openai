Class St.OpenAi.OpenAiAPI Extends St.OpenAi.Abstract.OpenAiAPI
{

/// Creates a new entry point to the OpenAPI API, handling auth and allowing access to the various API endpoints
Method %OnNew(auth As St.OpenAi.Abstract.ApiAuthentication, Output valid As %Status) As %Status
{
    set valid = $$$OK

    set ..Auth = auth
    set api = ..%ConstructClone()
    set valid = ..%ValidateObject() // validate the new object
    write auth.ApiKey,"",auth.OpenAIOrganization

    return $$$OK
}

}
