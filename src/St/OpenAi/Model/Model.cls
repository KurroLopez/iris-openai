Include St.OpenAi.ModelNames

Class St.OpenAi.Model.Model Extends (%RegisteredObject, %JSON.Adaptor)
{

/// The id/name of the model
Property ModelID As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// The owner of this model.
Property OwnedBy As %String(%JSONFIELDNAME = "owned_by", MAXLEN = "");

/// The type of object. Should always be 'model'
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// The time when the result was generated
Property Created As %TimeStamp(%JSONINCLUDE = "none");

/// Override method to return UnixTime in Timestamp format
Method CreatedGet() As %TimeStamp
{
    if (..CreatedUnixTime > 0) 
    {
        return $ZDATETIMEH(..CreatedUnixTime,-2) 
    }
    else 
    {
        return $ZDATETIMEH(0,-2)
    }
}

/// The time when the model was created in unix epoch format
Property CreatedUnixTime As %Integer(%JSONFIELDNAME = "created");

/// Permissions for use of the model
Property Permission As list Of St.OpenAi.Model.Permissions(%JSONFIELDNAME = "permission", XMLPROJECTION = "ELEMENT");

/// Seems like this is duplicate of ModelID, but including for completeness.
Property Root As %String(%JSONFIELDNAME = "root", MAXLEN = "");

/// Seems unused, probably intended for nesting of models in a later release
Property Parent As %String(%JSONFIELDNAME = "parent", MAXLEN = "");

/// Initialize the model
Method %OnNew(modelId As %String = "", owner As %String = "", Output valid As %Status) As %Status
{
    set valid = $$$OK

    set ..ModelID = modelId
    set ..OwnedBy = owner
    set valid = ..%ValidateObject() // validate the new object

    return $$$OK
}

/* Definition of models on OpenAI */
/// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost
Property AdaText As Model(%JSONINCLUDE = "none");

Method AdaTextGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$AdaText, $$$DefaultOwnedBy)
}

/// Capable of straightforward tasks, very fast, and lower cost.
Property BabbageText As Model(%JSONINCLUDE = "none");

Method BabbageTextGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$BabbageText, $$$DefaultOwnedBy)
}

/// Very capable, but faster and lower cost than Davinci.
Property CurieText As Model(%JSONINCLUDE = "none");

Method CurieTextGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$CurieText, $$$DefaultOwnedBy)
}

/// Most capable GPT-3 model. Can do any task the other models can do, often with higher quality, longer output and better instruction-following. Also supports inserting completions within text.
Property DavinciText As Model(%JSONINCLUDE = "none");

Method DavinciTextGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$DavinciText, $$$DefaultOwnedBy)
}

/// Almost as capable as Davinci Codex, but slightly faster. This speed advantage may make it preferable for real-time applications.
Property CushmanCode As Model(%JSONINCLUDE = "none");

Method CushmanCodeGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$CushmanCode, $$$DefaultOwnedBy)
}

/// Most capable Codex model. Particularly good at translating natural language to code. In addition to completing code, also supports inserting completions within code.
Property DavinciCode As Model(%JSONINCLUDE = "none");

Method DavinciCodeGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$DavinciCode, $$$DefaultOwnedBy)
}

/// OpenAI offers one second-generation embedding model for use with the embeddings API endpoint.
Property AdaTextEmbedding As Model(%JSONINCLUDE = "none");

Method AdaTextEmbeddingGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$AdaTextEmbedding, $$$DefaultOwnedBy)
}

/// Most capable GPT-3.5 model and optimized for chat at 1/10th the cost of text-davinci-003. Will be updated with the latest model iteration.
Property ChatGPTTurbo As Model(%JSONINCLUDE = "none");

Method ChatGPTTurboGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$ChatGPTTurbo, $$$DefaultOwnedBy)
}

/// Snapshot of gpt-3.5-turbo from March 1st 2023. Unlike gpt-3.5-turbo, this model will not receive updates, and will only be supported for a three month period ending on June 1st 2023.
Property ChatGPTTurbo0301 As Model(%JSONINCLUDE = "none");

Method ChatGPTTurbo0301Get() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$ChatGPTTurbo0301, $$$DefaultOwnedBy)
}

/// More capable than any GPT-3.5 model, able to do more complex tasks, and optimized for chat. Will be updated with the latest model iteration.  Currently in limited beta so your OpenAI account needs to be whitelisted to use this.
Property GPT4 As Model(%JSONINCLUDE = "none");

Method GPT4Get() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$GPT4, $$$DefaultOwnedBy)
}

/// Same capabilities as the base gpt-4 mode but with 4x the context length. Will be updated with the latest model iteration.  Currently in limited beta so your OpenAI account needs to be whitelisted to use this.
Property GPT432kContext As Model(%JSONINCLUDE = "none");

Method GPT432kContextGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$GPT432kContext, $$$DefaultOwnedBy)
}

/// Stable text moderation model that may provide lower accuracy compared to TextModerationLatest.
/// OpenAI states they will provide advanced notice before updating this model.
Property TextModerationStable As Model(%JSONINCLUDE = "none");

Method TextModerationStableGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$TextModerationStable, $$$DefaultOwnedBy)
}

/// The latest text moderation model. This model will be automatically upgraded over time.
Property TextModerationLatest As Model(%JSONINCLUDE = "none");

Method TextModerationLatestGet() As Model
{
    return ##class(St.OpenAi.Model.Model).%New($$$TextModerationLatest, $$$DefaultOwnedBy)
}

/// Default model
Property DefaultModel As Model(%JSONINCLUDE = "none");

Method DefaultModelGet() As Model
{
    return ..DavinciText
}

}
