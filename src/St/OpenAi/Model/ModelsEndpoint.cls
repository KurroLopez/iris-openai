Class St.OpenAi.Model.ModelsEndpoint Extends (St.OpenAi.Base.Endpoint, St.OpenAi.Abstract.ModelsEndpoint)
{

/// The name of the endpoint, which is the final path segment in the API URL.  For example, "models".
Method EndpointGet() As %String
{
    return "models"
}

/// Get details about a particular Model from the API, specifically properties such as Model.OwnedBy and permissions.
Method RetrieveModelDetails(id As %String) As St.OpenAi.Model.Model
{
    set model = ##class(St.OpenAi.Model.Model).%New()
    set content = ..HttpGetContent($$$FormatText("%1/%2",..Api.Url, id))
    // Serialize to model
    do model.%JSONImport(content)
    return model
}

/// List all models via the API
Method GetModels() As %ListOfObjects(ELEMENTTYPE="St.OpenAi.Model.Model")
{
    set pResponse = ##class("St.OpenAi.Model.ListModel").%New()

    set tSc = ..HttpGet(,.pResponse)
    return pResponse.Data
}

}
