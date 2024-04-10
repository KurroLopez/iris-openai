Class Demo.Msg.SpeachRequest Extends (Ens.Request, %JSON.Adaptor)
{

/// The model to use for this request
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "", VALUELIST = ",tts-1,tts-1-hd") [ InitialExpression = "tts-1-hd" ];

/// The text to generate audio for. The maximum length is 4096 characters.
Property Prompt As %String(%JSONFIELDNAME = "input", MAXLEN = 4096) [ Required ];

/// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer
Property Voice As %String(%JSONFIELDNAME = "voice", VALUELIST = ",alloy,echo,fable,onyx,nova,shimmer") [ InitialExpression = "alloy" ];

Storage Default
{
<Data name="SpeachRequestDefaultData">
<Subscript>"SpeachRequest"</Subscript>
<Value name="1">
<Value>Model</Value>
</Value>
<Value name="2">
<Value>Prompt</Value>
</Value>
<Value name="3">
<Value>Voice</Value>
</Value>
</Data>
<DefaultData>SpeachRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
