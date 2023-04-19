Class St.OpenAi.Model.Permissions Extends (%RegisteredObject, %JSON.Adaptor)
{

/// Permission Id (No to be confused with ModeId)
Property Id As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// Object type, should always be 'model_permission'
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// Unix timestamp for creation date/time
Property CreatedUnixTime As %Integer(%JSONFIELDNAME = "created");

/// The time when the permission was created
Property Created As %TimeStamp(%JSONINCLUDE = "none");

/// Override method to return UnixTime in Timestamp format
Method CreatedGet() As %TimeStamp
{
    if (..CreatedUnixTime > 0) return $ZDATETIMEH(..CreatedUnixTime,-2)
}

/// Can the model be created?
Property AllowCreateEngine As %Boolean(%JSONFIELDNAME = "allow_create_engine");

/// Does the model support temperature sampling?
/// https://beta.openai.com/docs/api-reference/completions/create#completions/create-temperature
Property AllowSampling As %Boolean(%JSONFIELDNAME = "allow_sampling");

/// Does the model support logprobs?
/// https://beta.openai.com/docs/api-reference/completions/create#completions/create-logprobs
Property AllowLogProbs As %Boolean(%JSONFIELDNAME = "allow_logprobs");

///  Does the model support search indices?
Property AllowSearchIndices As %Boolean(%JSONFIELDNAME = "allow_search_indices");

///  Does the model support views?
Property AllowView As %Boolean(%JSONFIELDNAME = "allow_view");

/// Does the model allow fine tuning?
/// https://beta.openai.com/docs/api-reference/fine-tunes
Property AllowFineTuning As %Boolean(%JSONFIELDNAME = "allow_fine_tuning");

/// Is the model only allowed for a particular organization? May not be implemented yet.
Property Organization As %String(%JSONFIELDNAME = "organization", MAXLEN = "");

/// Is the model part of a group? Seems not implemented yet. Always null.
Property Group As %String(%JSONFIELDNAME = "group", MAXLEN = "");

///  Does the model blocking?
Property IsBlocking As %Boolean(%JSONFIELDNAME = "is_blocking");

}
