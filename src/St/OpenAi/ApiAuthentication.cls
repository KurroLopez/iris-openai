Class St.OpenAi.ApiAuthentication Extends St.OpenAi.Abstract.ApiAuthentication
{

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
    set auth = ..%ConstructClone()
    set api=##class(St.OpenAi.OpenAiAPI).%New(auth)

    set result = api.Models.GetModels()

    return (result.Count() > 0)
}

}
