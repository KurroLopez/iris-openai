Include Banksia.OpenAi.OpenAi

Class Banksia.OpenAi.Operation Extends EnsLib.REST.Operation
{

Parameter PathModel = "models";

Parameter PathChat = "chat/completions";

Parameter PathImageGenerations = "images/generations";

Parameter PathImageEdits = "images/edits";

Parameter PathImageVariations = "images/variations";

Parameter PathAudioTranscriptions = "audio/transcriptions";

Parameter PathAudioTranslations = "audio/translations";

Parameter DefaultNumOutputs = 5;

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

/// ApiKey Credentials of your api connection. Put Api key into Password field of credentials. [MANDATORY]
Property Credentials As %String;

/// Organization ID defined in your OpenAI accoount
Property Organization As %String(MAXLEN = "");

Parameter SETTINGS = "Organization:Basic";

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

Method CallApi(pPath As %String, pParameter = "", pVerb As %String = "GET", Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    #Dim excepcion As %Exception.AbstractException

    Set pResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
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
        if (statusCode '= 200)
        {
	        $$$TRACE("Content: "_content)
            set objError = ##class(%DynamicAbstractObject).%FromJSON(content)
            $$$ThrowStatus($$$ERROR($$$GeneralError, "Error "_statusCode_" - "_objError.error.message))
        }
        if $$$ISERR(tSC) $$$ThrowStatus(tSC)

        set pResponse.Content = ##class(%DynamicAbstractObject).%FromJSON(content)
    }
    catch excepcion
    {
        set ret = excepcion.AsStatus()
    }
    
    Quit ret
}

/// Call api using webform but 
/// pListFiles contains the list of parameter that is a Bas64 content and needs to convert to file into the nime body
Method CallWebForm(pPath As %String, pParameter As %ArrayOfDataTypes, pVerb As %String = "GET", pListParameters As %ArrayOfDataTypes, pContentTypeFiles As %String, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    Set pResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
    set ret = $$$OK

    set url = $$$FormatText(..#ApiUrlFormat,..#ApiVersion, pPath)
    set ..Adapter.URL = url
    set ..Adapter.HTTPServer = ..#OpenAiServer
    $$$TRACE("Url: "_url)
    try
    {
        set tSC = ..initializeRest(.tHttpRequest)
        $$$ThrowOnError(tSC)

        set idBody = 0
        // Take the parameter to convert as stream
        if ($DATA(pListParameters))
        {
            For i=1:1:pListParameters
            {
                set parameter = $List(pListParameters(i),1)
                set jsonName = $List(pListParameters(i),2)
                set fileName = $List(pListParameters(i),3)
                set value = $PROPERTY(pParameter, parameter)
                set content = ##class(%Net.MIMEPart).%New()
                set contentDisposition = "form-data; name="_$CHAR(34)_jsonName_$CHAR(34)
                if (fileName '= "")
                {
                    set contentDisposition = contentDisposition_"; filename="_$CHAR(34)_fileName_$CHAR(34)
                    do content.SetHeader("Content-Disposition",contentDisposition)
                    set contentfile = {}
                    set contentfile.file = value

                    set content.Body = contentfile.%Get("file",,"stream<base64")
                    set listBody($Increment(idBody)) = content
                }
                else
                {
                    do content.SetHeader("Content-Disposition",contentDisposition)
                    set content.Body = value
                    set listBody($Increment(idBody)) = content
                }
            }
        }
        Set rootMIME = ##class(%Net.MIMEPart).%New()
        for i=1:1:idBody
        {
            do rootMIME.Parts.Insert(listBody(i))
        }
        set writer = ##class(%Net.MIMEWriter).%New()
        set tSC = writer.OutputToStream(tHttpRequest.EntityBody)
        $$$ThrowOnError(tSC)
        set tSC = writer.WriteMIMEBody(rootMIME)
        $$$ThrowOnError(tSC)

        Set tContentType = "multipart/form-data; boundary="_rootMIME.Boundary
        Set tSC = tHttpRequest.SetHeader("Content-Type",tContentType)
        Set tSC = tHttpRequest.SetHeader("CharSet","utf-8")

        set tSC = ..Adapter.SendFormDataArray(.tHttpResponse, pVerb, tHttpRequest,,,url)
        #; if $$$ISERR(tSC) $$$ThrowStatus(tSC)
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
        if (statusCode '= 200)
        {
	        $$$TRACE("Content: "_content)
            set objError = ##class(%DynamicAbstractObject).%FromJSON(content)
            $$$ThrowStatus($$$ERROR($$$GeneralError, "Error "_statusCode_" - "_objError.error.message))
        }
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
    if (..Adapter.%CredentialsObj = "") Quit ($$$ERROR($$$GeneralError, "You must provide API authentication credentials."))
    set apiKey=..Adapter.%CredentialsObj.Password
    if (apiKey = "") Quit ($$$ERROR($$$GeneralError, "You must provide API authentication in Password field of Credentials."))

    set pRequest=##class(%Net.HttpRequest).%New()
    set pRequest.Server = ..#OpenAiServer
    set pRequest.UserAgent = ..#UserAgent
    set pRequest.ContentType = "application/json; charset=utf-8"

    #; do pRequest.SetHeader("Accept-Charset", "utf-8")
    do pRequest.SetHeader("Authorization", $$$FormatText("Bearer %1",apiKey))
    do pRequest.SetHeader("api-key", apiKey)
    if (..Organization '= "") do pRequest.SetHeader("OpenAI-Organization", ..Organization)

    Quit $$$OK
}

/// Update extra content of API response
Method UpdateExtraContent(info As Banksia.OpenAi.Msg.Api.CallApi, pResponse As Banksia.OpenAi.Msg.Api.Response) As %Status
{
    set pResponse.Organization = info.Organization
    set pResponse.RequestId = info.RequestId
    set pResponse.OpenaiVersion = info.OpenaiVersion

    quit $$$OK
}

/// Get the list of models availables
Method ListModels(pRequest As Banksia.OpenAi.Msg.ListModel.Request, Output pResponse As Banksia.OpenAi.Msg.ListModel.Response) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        set tSC = ..CallApi(..#PathModel,,,.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(Banksia.OpenAi.Msg.ListModel.Response).%New()
        do pResponse.%JSONImport(apiResponse.Content)
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Get a specific model
Method GetModel(pRequest As Banksia.OpenAi.Msg.Model.Request, Output pResponse As Banksia.OpenAi.Msg.Model.Response) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        set path = $$$FormatText("%1/%2",..#PathModel, pRequest.Model)
        set tSC = ..CallApi(path,,,.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(Banksia.OpenAi.Msg.Model.Response).%New()
        do pResponse.ModelObject.%JSONImport(apiResponse.Content)
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to complete the request using the specified parameters. This is non-streaming, so it will wait until the API returns the full result. 
/// Any non-specified parameters will fall back to default values specified in DefaultChatRequestArgs if present.
Method CreateChatCompletion(pRequest As Banksia.OpenAi.Msg.Chat.Request, Output pResponse As Banksia.OpenAi.Msg.Chat.Response) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        if pRequest.NumChoicesPerMessage = 0 set pRequest.NumChoicesPerMessage = ..#DefaultNumOutputs
        set tSC = ..CallApi(..#PathChat,pRequest,"POST",.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(Banksia.OpenAi.Msg.Chat.Response).%New()
        do pResponse.%JSONImport(apiResponse.Content)
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to perform text based task using a simple prompt
Method GetSimplePrompt(pRequest As Banksia.OpenAi.Msg.SimplePrompt.Request, Output pResponse As Banksia.OpenAi.Msg.SimplePrompt.Response) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        set ChatRequest=##class(Banksia.OpenAi.Msg.Chat.Request).%New()
        $$$ThrowOnError(pRequest.%JSONExportToString(.requestJson))
        $$$ThrowOnError(ChatRequest.%JSONImport(requestJson))
        set ChatRequest.NumChoicesPerMessage = 1
        set ChatRequest.Stream=0
        set SystemMessage=##class(Banksia.OpenAi.Msg.Chat.Message).%New()
        set SystemMessage.Role="system"
        set SystemMessage.Content=pRequest.Prompt
        do ChatRequest.Messages.Insert(SystemMessage)
        set UserMessage=##class(Banksia.OpenAi.Msg.Chat.Message).%New()
        set UserMessage.Role="user"
        set UserMessage.Content=pRequest.UserInput
        do ChatRequest.Messages.Insert(UserMessage)
        set tSC = ..CallApi(..#PathChat,ChatRequest,"POST",.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set ChatResponse = ##class(Banksia.OpenAi.Msg.Chat.Response).%New()
        $$$ThrowOnError(ChatResponse.%JSONImport(apiResponse.Content))
        set pResponse = ##class(Banksia.OpenAi.Msg.SimplePrompt.Response).%New()
        set pResponse.Content=ChatResponse.Choices.GetAt(1).Message.Content
        set pResponse.Usage=ChatResponse.Usage
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to Creates an image given a prompt.
Method GetImages(pRequest As Banksia.OpenAi.Msg.Images.Request, Output pResponse As Banksia.OpenAi.Msg.Images.Response) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        if (pRequest.Operation = $$$ImageVariations) set tSC = ..GetVariateImages(pRequest, .apiResponse)
        if (pRequest.Operation = $$$ImageEdits) set tSC = ..GetEditImages(pRequest, .apiResponse)
        if (pRequest.Operation = $$$ImageGenerations) set tSC = ..GetCreateImages(pRequest, .apiResponse)
        $$$ThrowOnError(tSC)
        
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(Banksia.OpenAi.Msg.Images.Response).%New()
        do pResponse.%JSONImport(apiResponse.Content)
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Create a new image acording to the prompt given
Method GetCreateImages(pRequest As Banksia.OpenAi.Msg.Images.Request, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    set status = $$$OK
    try
    {
        set path = ..#PathImageGenerations
        set tSC = ..CallApi(path,pRequest,"POST",.pResponse)
        $$$ThrowOnError(tSC)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to variate an image
Method GetVariateImages(pRequest As Banksia.OpenAi.Msg.Images.Request, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    set status = $$$OK
    try
    {
        set path = ..#PathImageVariations
        set pContentType = "image/png" // All files mus to be a PNG
        // Create a randomn name of the parameter image
        set fileName = $System.Util.CreateGUID()_".png"
        set id = 0
        set pListParameters($INCREMENT(id)) = $Listbuild("Image","image",fileName)
        if pRequest.NumOfImages > 0 set pListParameters($INCREMENT(id)) = $Listbuild("NumOfImages","n","")
        if pRequest.Size '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Size","size","")
        if pRequest.ResponseFormat '= "" set pListParameters($INCREMENT(id)) = $Listbuild("ResponseFormat","response_format","")
        set pListParameters = id

        set tSC = ..CallWebForm(path, pRequest, "POST", .pListParameters, pContentType, .pResponse)
        $$$ThrowOnError(tSC)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to edit an image
Method GetEditImages(pRequest As Banksia.OpenAi.Msg.Images.Request, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    set status = $$$OK
    try
    {
        set path = ..#PathImageEdits
        set pContentType = "image/png" // All files mus to be a PNG
        // Create a randomn name of the parameter image
        set id = 0
        set fileName = $System.Util.CreateGUID()_".png"
        set pListParameters($INCREMENT(id)) = $Listbuild("Image","image",fileName)
        set fileName = $System.Util.CreateGUID()_".png"
        set pListParameters($INCREMENT(id)) = $Listbuild("Mask","mask",fileName)
        if pRequest.Prompt '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Prompt","prompt","")
        if pRequest.NumOfImages > 0 set pListParameters($INCREMENT(id)) = $Listbuild("NumOfImages","n","")
        if pRequest.Size '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Size","size","")
        if pRequest.ResponseFormat '= "" set pListParameters($INCREMENT(id)) = $Listbuild("ResponseFormat","response_format","")
        set pListParameters = id

        set tSC = ..CallWebForm(path, pRequest, "POST", .pListParameters, pContentType, .pResponse)
        $$$ThrowOnError(tSC)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Manage an audio to translate or transcript
Method GetAudio(pRequest As Banksia.OpenAi.Msg.Audio.Request, Output pResponse As Banksia.OpenAi.Msg.Audio.Response) As %Status
{
    set status = $$$OK
    try
    {
        // Add by default the name of the model. It should be 'whisper-1'
        if pRequest.Model = "" set pRequest.Model = $$$Whisper
        set apiResponse = ##class(Banksia.OpenAi.Msg.Api.CallApi).%New()
        if (pRequest.Operation = $$$AudioTranslation) set tSC = ..GetAudioTranslation(pRequest, .apiResponse)
        if (pRequest.Operation = $$$AudioTranscription) set tSC = ..GetAudioTranscription(pRequest, .apiResponse)
        $$$ThrowOnError(tSC)
        
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(Banksia.OpenAi.Msg.Audio.Response).%New()
        do pResponse.%JSONImport(apiResponse.Content)
        do ..UpdateExtraContent(apiResponse, .pResponse)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to translation of an audio
Method GetAudioTranslation(pRequest As Banksia.OpenAi.Msg.Audio.Request, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    set status = $$$OK
    try
    {
        set path = ..#PathAudioTranslations
        set pContentType = "application/json"
        // Create a randomn name of the parameter audio
        set fileName = $System.Util.CreateGUID()_"."_pRequest.Type
        set id = 0
        set pListParameters($INCREMENT(id)) = $Listbuild("Audio","file",fileName)
        if pRequest.Model '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Model","model","")
        if pRequest.ResponseFormat '= "" set pListParameters($INCREMENT(id)) = $Listbuild("ResponseFormat","response_format","")
        if pRequest.Language '= "" set pListParameters($INCREMENT(id)) = $LISTBUILD("Language","lang","")
        set pListParameters = id

        set tSC = ..CallWebForm(path, pRequest, "POST", .pListParameters, pContentType, .pResponse)
        $$$ThrowOnError(tSC)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// Ask the API to transcript of an audio
Method GetAudioTranscription(pRequest As Banksia.OpenAi.Msg.Audio.Request, Output pResponse As Banksia.OpenAi.Msg.Api.CallApi) As %Status
{
    set status = $$$OK
    try
    {
        set path = ..#PathAudioTranscriptions
        set pContentType = "application/json"
        // Create a randomn name of the parameter audio
        set fileName = $System.Util.CreateGUID()_"."_pRequest.Type
        set id = 0
        set pListParameters($INCREMENT(id)) = $Listbuild("Audio","file",fileName)
        if pRequest.Model '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Model","model","")
        if pRequest.Prompt '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Prompt","prompt","")
        if pRequest.Temperature '= "" set pListParameters($INCREMENT(id)) = $Listbuild("Temperature","temperature","")
        if pRequest.ResponseFormat '= "" set pListParameters($INCREMENT(id)) = $Listbuild("ResponseFormat","response_format","")
        set pListParameters = id

        set tSC = ..CallWebForm(path, pRequest, "POST", .pListParameters, pContentType, .pResponse)
        $$$ThrowOnError(tSC)
    }
    Catch ex {
        set status = ex.AsStatus()
        set msgError = $System.Status.GetOneStatusText(status,1)
        $$$ThrowOnError($System.Status.Error(5001,"Internal error: "_msgError))

    }
    return status
}

/// MessageMap
XData MessageMap
{
<MapItems>
    <MapItem MessageType="Banksia.OpenAi.Msg.ListModel.Request">
        <Method>ListModels</Method>
    </MapItem>
    <MapItem MessageType="Banksia.OpenAi.Msg.Model.Request">
        <Method>GetModel</Method>
    </MapItem>
    <MapItem MessageType="Banksia.OpenAi.Msg.Chat.Request">
        <Method>CreateChatCompletion</Method>
    </MapItem>
    <MapItem MessageType="Banksia.OpenAi.Msg.Images.Request">
        <Method>GetImages</Method>
    </MapItem>
    <MapItem MessageType="Banksia.OpenAi.Msg.Audio.Request">
        <Method>GetAudio</Method>
    </MapItem>
    <MapItem MessageType="Banksia.OpenAi.Msg.SimplePrompt.Request">
        <Method>GetSimplePrompt</Method>
    </MapItem>
</MapItems>
}

}
