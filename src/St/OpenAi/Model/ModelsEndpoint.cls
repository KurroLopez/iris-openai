Class St.OpenAi.Model.ModelsEndpoint Extends (St.OpenAi.Base.Endpoint, St.OpenAi.Abstract.ModelsEndpoint)
{

/// The name of the endpoint, which is the final path segment in the API URL.  For example, "models".
Method EndpointGet() As %String
{
    return "models"
}

/// Get details about a particular Model from the API, specifically properties such as Model.OwnedBy and permissions.
Method RetrieveModelDetails(id As %String, model As St.OpenAi.Model.Model) As %Status
{
    #dim ex As %Exception.AbstractException
    set res = $$$OK
    try {
        set model = ##class(St.OpenAi.Model.Model).%New()
        set tSc = ..HttpGetContent($$$FormatText("%1/%2",..Api.Url, id), .content)
        $$$ThrowOnError(tSc)
        // Serialize to model
        do model.%JSONImport(content)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return res
}

/// List all models via the API
Method GetModels(models As %ListOfObjects(ELEMENTTYPE="St.OpenAi.Model.Model")) As %Status
{
    #dim ex As %Exception.AbstractException
    set res = $$$OK
    Try {
        set pResponse = ##class("St.OpenAi.Model.ListModel").%New()

        $$$ThrowOnError(..HttpGet(,.pResponse))
        set models = pResponse.Data
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))
    }
    return res
}

}
