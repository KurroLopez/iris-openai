Class St.OpenAi.ApiAuthentication Extends %Library.RegisteredObject
{

/// The API Key, required to access the API endpoint.
Property ApiKey As %String(MAXLEN = "");

/// Organization ID
Property OpenAIOrganization As %String(MAXLEN = "");

/// New parameters to init the auth api
Method %OnNew(apiKey As %String = "", organizationId As %String = "", Output valid As %Status) As %Status
{
    set valid = $$$OK

    set ..ApiKey = apiKey
    set ..OpenAIOrganization = organizationId
    set valid = ..%ValidateObject() // validate the new object

    return $$$OK
}

/// Validate the API Key
Method ValidateApiKey() As %Boolean
{
    if ..ApiKey = ""
    {
        return $$$NO
    }

    #; set obj=##class(OpenAiApi())
}

}
