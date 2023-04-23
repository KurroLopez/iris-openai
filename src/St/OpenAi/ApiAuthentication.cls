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
Method ValidateApiKey() As %Status
{
    #dim ex As %Exception.AbstractException
    set status = $$$OK
    
    try {
        if ..ApiKey = "" $$$ThrowOnError($$$ERROR($$$GeneralError, "ApiKey is mandatory"))

        set auth = ..%ConstructClone()
        set api=##class(St.OpenAi.OpenAiAPI).%New(auth)

        $$$ThrowOnError(api.Models.GetModels(.models))
        
        if ((models = "") || (models.Count() = 0)) $$$ThrowOnError($$$ERROR($$$GeneralError, "No models have been retrieved"))
    }
    Catch ex {
        set status = ex.AsStatus()
    }
    return status
}

}
