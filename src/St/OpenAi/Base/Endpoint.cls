Class St.OpenAi.Base.Endpoint Extends %Library.RegisteredObject
{

/// UserAgent
Parameter USERAGENT = "salutic/iris_openai_api";

/// Internal reference to the API, mostly used for authentati
Property Api As St.OpenAi.Abstract.OpenAiAPI;

/// Gets the URL of the endpoint, based on the base OpenAI API URL followed by the endpoint name.  For example "https://api.openai.com/v1/completions"
Method Url() As %String
{
    return ..Api.ApiUrlFormat
}

/// Constructor of the api endpoint base, to be called from the contructor of any devived classes. 
/// Rather than instantiating any endpoint yourself, access it through an instance of OpenAIAPI.
Method %OnNew(api As St.OpenAi.Abstract.OpenAiAPI, Output valid As %Status) As %Status
{
   set valid = $$$OK

    set ..Api = api
    set valid = ..%ValidateObject() // validate the new object
    return $$$OK
}

}
