Include Banksia.OpenAi.OpenAi

Class Banksia.OpenAi.Msg.Model.Model Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// The id/name of the model
Property ModelID As %String(%JSONFIELDNAME = "id", MAXLEN = "");

/// The owner of this model.
Property OwnedBy As %String(%JSONFIELDNAME = "owned_by", MAXLEN = "");

/// The type of object. Should always be 'model'
Property Object As %String(%JSONFIELDNAME = "object", MAXLEN = "");

/// The time when the model was created in unix epoch format
Property Created As %Integer(%JSONFIELDNAME = "created");

/// Permissions for use of the model
Property Permission As list Of Banksia.OpenAi.Msg.Model.Permissions(%JSONFIELDNAME = "permission", XMLPROJECTION = "ELEMENT");

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

Storage Default
{
<Data name="ModelState">
<Value name="1">
<Value>ModelID</Value>
</Value>
<Value name="2">
<Value>OwnedBy</Value>
</Value>
<Value name="3">
<Value>Object</Value>
</Value>
<Value name="4">
<Value>Created</Value>
</Value>
<Value name="5">
<Value>Permission</Value>
</Value>
<Value name="6">
<Value>Root</Value>
</Value>
<Value name="7">
<Value>Parent</Value>
</Value>
</Data>
<State>ModelState</State>
<StreamLocation>^Banksia.OpenAi.Msg.Model.ModelS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
