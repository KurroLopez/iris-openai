Class St.OpenAi.Base.Endpoint Extends %Library.RegisteredObject
{

/// UserAgent
Parameter USERAGENT = "salutic/iris_openai_api";

/// Internal reference to the API, mostly used for authentati
Property Api As St.OpenAi.Abstract.OpenAiAPI;

/// THe name of the endpoint, witch is the final path segment in the API URL. Must be override in a subclass
Property Endpoint As %String;

Method EndpointSet(value As %String) As %Status
{
 
    // Do nothing. This propertu is intialized and readonly
}

Method EndpointGet() As %String [ Abstract ]
{
    Quit $$$ERROR($$$GeneralError, "EndpointGet not implemented by " _ ..%ClassName(1))
}

/// Gets the URL of the endpoint, based on the base OpenAI API URL followed by the endpoint name.  For example "https://api.openai.com/v1/completions"
Property Url As %String(MAXLEN = "");

Method UrlSet(value As %String) As %Status
{
    // Do nothing. This property is calculated and readonly
}

Method UrlGet() As %String
{
    return $$$FormatText(..Api.ApiUrlFormat,..Api.ApiVersion, ..Endpoint)
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
