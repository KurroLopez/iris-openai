Class St.OpenAi.Model.ModelsEndpoint Extends (St.OpenAi.Base.Endpoint, St.OpenAi.Abstract.ModelsEndpoint)
{

/// The name of the endpoint, which is the final path segment in the API URL.  For example, "models".
Method EndpointGet() As %String
{
        return "models"
}

}
