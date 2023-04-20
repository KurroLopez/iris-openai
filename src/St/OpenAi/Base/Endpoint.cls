Include St.OpenAi.HttpStatus

Class St.OpenAi.Base.Endpoint Extends %Library.RegisteredObject
{

/// SSL configuration name used for HTTPS requests.
Parameter SSLConfigName = "OpenAiSSL";

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

/// Gets an %Net.HttpRequest with the appropriate authorization and other headers set
Method GetRequest() As %Net.HttpRequest
{
    if (..Api.Auth.ApiKey = "")
    {
        Quit $$$ERROR($$$GeneralError, "You must provide API authentication.")
    }
    set request = ##class(%Net.HttpRequest).%New()
    
    if ($IsObject(..Api.HttpClientFactory))
    {
        set request = ..Api.HttpClientFactory
    }
    set request.UserAgent = ..#USERAGENT

    set header = ##class(%ArrayOfDataTypes).%New()
    do header.SetAt($$$FormatText("Bearer %1",..Api.Auth.ApiKey),"Authorization")  // Add bearer auth
    do header.SetAt(..Api.Auth.ApiKey,"api-key")
    
    if (..Api.Auth.OpenAIOrganization '= "") do header.SetAt(..Api.Auth.OpenAIOrganization,"OpenAI-Organization")
    
    // Add headers
    if ($DATA(header))
    {
        if (header.Count() > 0)
        {
            set key = ""
            for {
                set value = header.GetNext(.key)
                quit:key=""
                do request.SetHeader(key, value)
            }
        }
    }
    return request
}

/// Call service and retrive the content as string
Method HttpGetContent(pUrl = "") As %String
{
    #dim pResponse As %Net.HttpResponse
    set tSC = ..HttpRequestRaw(pUrl,,,,.pResponse)
    set content = ""
    while (pResponse.Data.AtEnd = 0) 
    { 
        set content = content_pResponse.Data.Read() 
    }
    return content
}

/// Call to the service and return the response object
Method HttpRequestRaw(pUrl As %String = "", pVerb As %String = "", pParameters = "", pStraming As %Boolean = 0, pResponse As %Net.HttpResponse) As %Status
{
    #dim ex As %Exception.AbstractException

    try
    {
        if (pUrl = "") set pUrl = ..Url
        if (pVerb = "") set pVerb = "GET"

        set request = ..GetRequest()
        set request.Server = ..Api.ApiServer
        set request.ContentType = "application/json,charset=utf-8"
        set request.Location = ..Url
        set request.Https = 1
        set request.SSLConfiguration = ..GetSSLConfigurationName()

        if (pVerb '= "GET")
        {
            Set tStream = ##class(%Stream.GlobalCharacter).%New()
            set checkClass = $CLASSMETHOD($CLASSNAME(pParameters),"%Extends","%JSON.Adaptor")
            if (checkClass > 0)
            {
                do pParameters.%JSONExportToStream(tStream)
            }else
            {
                do pParameters.%ToJSON(tStream)
            }
            do request.EntityBody.CopyFrom(tStream)
        }

        set tSC = request.Send(pVerb, ..Url)
        if $$$ISERR(tSC) && (request.HttpResponse="") $$$ThrowStatus(tSC)
        set statusCode = request.HttpResponse.StatusCode
        set pResponse = request.HttpResponse

        if (statusCode = $$$HttpStatusOk)
        {
            // Already has been taken response object
        }
        if (statusCode = $$$HttpStatusUnauthorized)
        {
            $$$ThrowOnError($System.Status.Error(5001,"OpenAI rejected your authorization, most likely due to an invalid API Key."))
        }
        if (statusCode = $$$HttpStatusInternalServerError)
        {
            $$$ThrowOnError($System.Status.Error(5001,"OpenAI had an internal server error, which can happen occasionally.  Please retry your request."))
        }
    }
    catch ex
    {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))
    }
    
    quit $$$OK
}

/// Sends an HTTP Request and does initial parsing
Method HttpRequest(pUrl = "", pVerb = "", pParameters = "", pResponse As St.OpenAi.Base.ApiResult)
{
    set res = $$$OK

    Try {
        set pResponseObject = ##class("%Net.HttpResponse").%New()
        set tSC = ..HttpRequestRaw(pUrl, pVerb, pParameters,, .pResponseObject)
        $$$ThrowOnError(tSC)

        set content = ""
        while (pResponseObject.Data.AtEnd = 0) 
        { 
            set content = content_pResponseObject.Data.Read() 
        }

        do pResponse.%JSONImport(content)

        set pResponse.Organization = pResponseObject.GetHeader("Openai-Organization")
        set pResponse.RequestId = pResponseObject.GetHeader("X-Request-ID")
        set pResponse.ProcessingTime = $ZDATETIMEH(pResponseObject.GetHeader("Openai-Processing-Ms"),-2) 
        set pResponse.OpenaiVersion = pResponseObject.GetHeader("Openai-Version")
        if (pResponse.Model = "")
        {
            set pResponse.Model = pResponseObject.GetHeader("Openai-Model")
        }
    }
    Catch ex {
        Set res=ex.AsStatus()
    }
    return res
}

/// Sends an HTTP Get request and does initial parsing
Method HttpGet(pUrl As %String = "", pResponse As St.OpenAi.Base.ApiResult) As %Status
{
    return ..HttpRequest(pUrl, "GET",,.pResponse)
}

/// Sends an HTTP Post request and does initial parsing
Method HttpPost(pUrl As %String = "", pParameter As %RegisteredObject, pResponse As St.OpenAi.Base.ApiResult) As %Status
{
 
    return ..HttpRequest(pUrl, "POST", pParameter, .pResponse)
}

/// Sends an HTTP Delete request and does initial parsing
Method HttpDelete(pUrl As %String = "", pParameter As %RegisteredObject, pResponse As St.OpenAi.Base.ApiResult) As %Status
{
 
    return ..HttpRequest(pUrl, "DELETE", pParameter, .pResponse)
}

/// Sends an HTTP Put request and does initial parsing
Method HttpPut(pUrl As %String = "", pParameter As %RegisteredObject, pResponse As St.OpenAi.Base.ApiResult) As %Status
{
 
    return ..HttpRequest(pUrl, "PUT", pParameter, .pResponse)
}

/// Get the SSL Config
ClassMethod GetSSLConfigurationName() As %String
{
    new $namespace
    zn "%SYS"
    if ('##class(Security.SSLConfigs).Exists(..#SSLConfigName)) {
        set st = ##class(Security.SSLConfigs).Create(..#SSLConfigName)
        return:(st '= 1) "UnableToCreateSSLConfig:"_$System.Status.GetErrorText(st)
    }
    return ..#SSLConfigName
}

}
