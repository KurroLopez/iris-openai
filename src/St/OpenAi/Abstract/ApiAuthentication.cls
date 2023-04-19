Class St.OpenAi.Abstract.ApiAuthentication Extends %Library.RegisteredObject [ Abstract ]
{

/// The API Key, required to access the API endpoint.
Property ApiKey As %String(MAXLEN = "");

/// Organization ID
Property OpenAIOrganization As %String(MAXLEN = "");

/// New parameters to init the auth api
Method %OnNew(apiKey As %String = "", organizationId As %String = "", Output valid As %Status) As %Status
{
    Quit $$$ERROR($$$GeneralError, "%OnNew not implemented by " _ ..%ClassName(1))
}

}
