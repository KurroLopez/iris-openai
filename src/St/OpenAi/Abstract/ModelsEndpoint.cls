Class St.OpenAi.Abstract.ModelsEndpoint Extends %Library.RegisteredObject [ Abstract ]
{

/// Get details about a particular Model from the API, specifically properties such as Model.OwnedBy and permissions.
Method RetrieveModelDetails(id As %String) As St.OpenAi.Model.Model
{
    Quit $$$ERROR($$$GeneralError, "RetrieveModelDetails not implemented by " _ ..%ClassName(1))
}

/// List all models via the API
Method GetModel() As %ListOfObjects(ELEMENTTYPE="St.OpenAi.Model.Model")
{
    Quit $$$ERROR($$$GeneralError, "GetModel not implemented by " _ ..%ClassName(1))
}

}
