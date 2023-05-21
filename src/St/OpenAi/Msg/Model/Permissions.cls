Class St.OpenAi.Msg.Model.Permissions Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// Permission Id (No to be confused with ModeId)
Property Id As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// Object type, should always be 'model_permission'
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// Unix timestamp for creation date/time
Property Created As %Integer(%JSONFIELDNAME = "created");

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

Storage Default
{
<Data name="PermissionsState">
<Value name="1">
<Value>Id</Value>
</Value>
<Value name="2">
<Value>Object</Value>
</Value>
<Value name="3">
<Value>Created</Value>
</Value>
<Value name="4">
<Value>AllowCreateEngine</Value>
</Value>
<Value name="5">
<Value>AllowSampling</Value>
</Value>
<Value name="6">
<Value>AllowLogProbs</Value>
</Value>
<Value name="7">
<Value>AllowSearchIndices</Value>
</Value>
<Value name="8">
<Value>AllowView</Value>
</Value>
<Value name="9">
<Value>AllowFineTuning</Value>
</Value>
<Value name="10">
<Value>Organization</Value>
</Value>
<Value name="11">
<Value>Group</Value>
</Value>
<Value name="12">
<Value>IsBlocking</Value>
</Value>
</Data>
<State>PermissionsState</State>
<StreamLocation>^St.OpenAi.MsgCC6C.PermissionsS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
