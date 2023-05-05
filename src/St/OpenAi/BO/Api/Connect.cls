Include St.OpenAi.OpenAi

Class St.OpenAi.BO.Api.Connect Extends St.OpenAi.BO.Api.Base
{

Parameter PathModel = "models";

Parameter PathChat = "chat/completions";

Parameter PathImageGenerations = "images/generations";

Parameter PathImageEdits = "images/edits";

Parameter PathImageVariations = "images/variations";

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
        set path = $CASE(pRequest.Operation,$$$ImageGenerations: ..#PathImageGenerations,$$$ImageEdits: ..#PathImageEdits, $$$ImageVariations: ..#PathImageVariations,:..#PathImageGenerations)
        set tSC = ..CallApi(path,pRequest,"POST",.apiResponse)
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
</MapItems>
}

}
