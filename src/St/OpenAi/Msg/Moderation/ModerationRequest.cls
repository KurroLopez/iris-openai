Class St.OpenAi.Msg.Moderation.ModerationRequest Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

/// The model to use for this request
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "", VALUELIST = ",text-moderation-latest,text-moderation-stable") [ InitialExpression = "text-moderation-latest" ];

/// The input text to classify
Property Input As %String(%JSONFIELDNAME = "input", MAXLEN = "") [ Required ];

Storage Default
{
<Data name="ModerationRequestDefaultData">
<Subscript>"ModerationRequest"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>Input</Value>
</Value>
</Data>
<DefaultData>ModerationRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
