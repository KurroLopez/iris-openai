Class St.OpenAi.BO.Api.Base Extends EnsLib.REST.Operation
{

/// SSL configuration name used for HTTPS requests.
Parameter SSLConfigName = "OpenAiSSL";

/// UserAgent
Parameter UserAgent = "salutic/iris_openai_api";

/// Format of URL of API
Parameter ApiUrlFormat = "%1/%2";

/// Server of OpenAi. The adapter HTTPServer value will be ignored
Parameter OpenAiServer = "api.openai.com";

/// API Version
Parameter ApiVersion = "v1";

/// ApiKey of your api connection. [MANDATORY]
Property ApiKey As %String(MAXLEN = "");

/// Organization ID defined in your OpenAI accoount
Property Organization As %String(MAXLEN = "");

Parameter SETTINGS = "ApiKey:Basic,Organization:Basic";

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

Method CallApi(pPath As %String, pParameter = "", pVerb As %String = "GET", Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
{
    #Dim excepcion As %Exception.AbstractException

    Set pResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
    set ret = $$$OK

    set url = $$$FormatText(..#ApiUrlFormat,..#ApiVersion, pPath)
    set ..Adapter.URL = url
    set ..Adapter.HTTPServer = ..#OpenAiServer
    try
    {
        set tSC = ..initializeRest(.tHttpRequest)
        $$$ThrowOnError(tSC)

        if (pVerb '= "GET")
        {
            // The parameters class is serialized as JSon
            set tStream = ##class(%Stream.GlobalCharacter).%New()
            do pParameter.%JSONExportToStream(.tStream)
            do tHttpRequest.EntityBody.CopyFrom(tStream)

        } else
        {
            // For GET parameters, pParameters is a Listbuild with param name and param value
            // set pParameters = $LISTBUILD($LISTBUILD("param1","value1"),$LISTBUILD("param2","value2"))
            if $GET(pParameter,0) '= 0
            {
                for i=1:1:$LISTLENGTH(pParameter)
                {
                    do tHttpRequest.SetParam($LIST($LIST(pParameter,i),1),$LIST($LIST(pParameter,i),2))
                }
            }
        }

        set tSC = ..Adapter.SendFormDataArray(.tHttpResponse, pVerb, tHttpRequest,,,url)
        if $$$ISERR(tSC) $$$ThrowStatus(tSC)
        // Check status code
        set statusCode = tHttpResponse.StatusCode
        set content = ""
        while (tHttpResponse.Data.AtEnd = 0)
        {
            set content = content_tHttpResponse.Data.Read()
        }
        // Get headers with the information
        set pResponse.Organization = ..Organization
        set pResponse.RequestId = tHttpResponse.GetHeader("x-request-id")
        set pResponse.OpenaiVersion = tHttpResponse.GetHeader("openai-version")

        // If statusCode is not 200, throw the exception and add the error message
        if (statusCode '= 200) $$$ThrowStatus($$$ERROR($$$GeneralError, "Error "_statusCode_" - "_content.error.message))
        set pResponse.Content = ##class(%DynamicAbstractObject).%FromJSON(content)
    }
    catch excepcion
    {
        set ret = excepcion.AsStatus()
    }
    
    Quit ret
}

/// Initialize the common parameters to start a HTTPRequest
Method initializeRest(Output pRequest As %Net.HttpRequest) As %Status
{
    if (..ApiKey = "") Quit ($$$ERROR($$$GeneralError, "You must provide API authentication."))

    set pRequest=##class(%Net.HttpRequest).%New()
    set pRequest.Server = ..#OpenAiServer
    set pRequest.UserAgent = ..#UserAgent
    set pRequest.ContentType = "application/json; charset=utf-8"

    #; do pRequest.SetHeader("Accept-Charset", "utf-8")
    do pRequest.SetHeader("Authorization", $$$FormatText("Bearer %1",..ApiKey))
    do pRequest.SetHeader("api-key", ..ApiKey)
    if (..Organization '= "") do pRequest.SetHeader("OpenAI-Organization", ..Organization)

    Quit $$$OK
}

/// Update extra content of API response
Method UpdateExtraContent(info As St.OpenAi.Msg.Api.CallApi, pResponse As St.OpenAi.Msg.Api.Response) As %Status
{
    set pResponse.Organization = info.Organization
    set pResponse.RequestId = info.RequestId
    set pResponse.OpenaiVersion = info.OpenaiVersion

    quit $$$OK
}

}
