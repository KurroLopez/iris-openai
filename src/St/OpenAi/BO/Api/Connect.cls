Include St.OpenAi.OpenAi

Class St.OpenAi.BO.Api.Connect Extends St.OpenAi.BO.Api.Base
{

Parameter PathModel = "models";

Parameter PathChat = "chat/completions";

Parameter PathImageGenerations = "images/generations";

Parameter PathImageEdits = "images/edits";

Parameter PathImageVariations = "images/variations";

Parameter PathAudioTranscriptions = "audio/transcriptions";

Parameter PathAudioTranslations = "audio/translations";

Parameter DefaultNumOutputs = 5;

/// Get the list of models availables
Method ListModels(pRequest As St.OpenAi.Msg.Model.ListModelRequest, Output pResponse As St.OpenAi.Msg.Model.ListModelResponse) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
        set tSC = ..CallApi(..#PathModel,,,.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(St.OpenAi.Msg.Model.ListModelResponse).%New()
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
Method GetModel(pRequest As St.OpenAi.Msg.Model.ModelRequest, Output pResponse As St.OpenAi.Msg.Model.ModelResponse) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
        set path = $$$FormatText("%1/%2",..#PathModel, pRequest.Model)
        set tSC = ..CallApi(path,,,.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(St.OpenAi.Msg.Model.ModelResponse).%New()
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
Method CreateChatCompletion(pRequest As St.OpenAi.Msg.Chat.ChatRequest, Output pResponse As St.OpenAi.Msg.Chat.ChatResponse) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
        if pRequest.NumChoicesPerMessage = 0 set pRequest.NumChoicesPerMessage = ..#DefaultNumOutputs
        set tSC = ..CallApi(..#PathChat,pRequest,"POST",.apiResponse)
        $$$ThrowOnError(tSC)
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(St.OpenAi.Msg.Chat.ChatResponse).%New()
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

/// Ask the API to Creates an image given a prompt.
Method GetImages(pRequest As St.OpenAi.Msg.Images.ImagesRequest, Output pResponse As St.OpenAi.Msg.Images.ImagesResponse) As %Status
{
    set status = $$$OK
    try
    {
        set apiResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
        if (pRequest.Operation = $$$ImageVariations) set tSC = ..GetVariateImages(pRequest, .apiResponse)
        if (pRequest.Operation = $$$ImageEdits) set tSC = ..GetEditImages(pRequest, .apiResponse)
        if (pRequest.Operation = $$$ImageGenerations) set tSC = ..GetCreateImages(pRequest, .apiResponse)
        $$$ThrowOnError(tSC)
        
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(St.OpenAi.Msg.Images.ImagesResponse).%New()
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
Method GetCreateImages(pRequest As St.OpenAi.Msg.Images.ImagesRequest, Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
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
Method GetVariateImages(pRequest As St.OpenAi.Msg.Images.ImagesRequest, Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
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
Method GetEditImages(pRequest As St.OpenAi.Msg.Images.ImagesRequest, Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
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
Method GetAudio(pRequest As St.OpenAi.Msg.Audio.AudioRequest, Output pResponse As St.OpenAi.Msg.Audio.AudioResponse) As %Status
{
    set status = $$$OK
    try
    {
        // Add by default the name of the model. It should be 'whisper-1'
        if pRequest.Model = "" set pRequest.Model = $$$Whisper
        set apiResponse = ##class(St.OpenAi.Msg.Api.CallApi).%New()
        if (pRequest.Operation = $$$AudioTranslation) set tSC = ..GetAudioTranslation(pRequest, .apiResponse)
        if (pRequest.Operation = $$$AudioTranscription) set tSC = ..GetAudioTranscription(pRequest, .apiResponse)
        $$$ThrowOnError(tSC)
        
        // All has gone well. Serialize the content into the class
        set pResponse = ##class(St.OpenAi.Msg.Audio.AudioResponse).%New()
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
Method GetAudioTranslation(pRequest As St.OpenAi.Msg.Audio.AudioRequest, Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
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
Method GetAudioTranscription(pRequest As St.OpenAi.Msg.Audio.AudioRequest, Output pResponse As St.OpenAi.Msg.Api.CallApi) As %Status
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
    <MapItem MessageType="St.OpenAi.Msg.Model.ListModelRequest">
        <Method>ListModels</Method>
    </MapItem>
    <MapItem MessageType="St.OpenAi.Msg.Model.ModelRequest">
        <Method>GetModel</Method>
    </MapItem>
    <MapItem MessageType="St.OpenAi.Msg.Chat.ChatRequest">
        <Method>CreateChatCompletion</Method>
    </MapItem>
    <MapItem MessageType="St.OpenAi.Msg.Images.ImagesRequest">
        <Method>GetImages</Method>
    </MapItem>
    <MapItem MessageType="St.OpenAi.Msg.Audio.AudioRequest">
        <Method>GetAudio</Method>
    </MapItem>
</MapItems>
}

}
