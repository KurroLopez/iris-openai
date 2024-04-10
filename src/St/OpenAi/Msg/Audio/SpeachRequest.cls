Class St.OpenAi.Msg.Audio.SpeachRequest Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

/// The model to use for this request
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "", VALUELIST = ",tts-1,tts-1-hd") [ InitialExpression = "tts-1-hd", Required ];

/// The text to generate audio for. The maximum length is 4096 characters.
Property Prompt As %String(%JSONFIELDNAME = "input", MAXLEN = 4096) [ Required ];

/// The voice to use when generating the audio. Supported voices are alloy, echo, fable, onyx, nova, and shimmer
Property Voice As %String(%JSONFIELDNAME = "voice", VALUELIST = ",alloy,echo,fable,onyx,nova,shimmer") [ InitialExpression = "alloy", Required ];

/// The format to audio in. Supported formats are mp3, opus, aac, and flac. 
/// Defaults to mp3
Property ResponseFormat As %String(%JSONFIELDNAME = "response_format", VALUELIST = ",mp3,opus,aac,flac") [ InitialExpression = "mp3" ];

/// The speed of the generated audio. Select a value from 0.25 to 4.0. 1.0 is the default.
Property Speed As %Decimal(%JSONFIELDNAME = "speed", MAXVAL = 4.0, MINVAL = 0.25) [ InitialExpression = 1.0 ];

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
<Value name="4">
<Value>ResponseFormat</Value>
</Value>
<Value name="5">
<Value>Speed</Value>
</Value>
</Data>
<DefaultData>SpeachRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
