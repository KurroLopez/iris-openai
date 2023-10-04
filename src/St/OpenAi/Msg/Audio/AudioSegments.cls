Class St.OpenAi.Msg.Audio.AudioSegments Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// Id
Property Id As %Integer(%JSONFIELDNAME = "id");

/// Seek
Property Seek As %Integer(%JSONFIELDNAME = "seek");

/// Start second
Property Start As %Integer(%JSONFIELDNAME = "start");

/// End second
Property End As %Decimal(%JSONFIELDNAME = "end");

/// Text of the transcription/translation
Property Text As %String(%JSONFIELDNAME = "text", MAXLEN = "");

/// List of tokens used
Property Tokens As list Of %Integer(%JSONFIELDNAME = "tokens");

/// Temperature used
Property Temperature As %Decimal(%JSONFIELDNAME = "temperature");

/// AvgLogProb
Property AvgLogProb As %Decimal(%JSONFIELDNAME = "avg_logprob");

/// Compression ratio
Property CompressionRatio As %Decimal(%JSONFIELDNAME = "compression_ratio");

/// No speech prob.
Property NoSpeechProb As %Decimal(%JSONFIELDNAME = "no_speech_prob");

Storage Default
{
<Data name="AudioSegmentsState">
<Value name="1">
<Value>Id</Value>
</Value>
<Value name="2">
<Value>Seek</Value>
</Value>
<Value name="3">
<Value>Start</Value>
</Value>
<Value name="4">
<Value>End</Value>
</Value>
<Value name="5">
<Value>Text</Value>
</Value>
<Value name="6">
<Value>Tokens</Value>
</Value>
<Value name="7">
<Value>Temperature</Value>
</Value>
<Value name="8">
<Value>AvgLogProb</Value>
</Value>
<Value name="9">
<Value>CompressionRatio</Value>
</Value>
<Value name="10">
<Value>NoSpeechProb</Value>
</Value>
</Data>
<State>AudioSegmentsState</State>
<StreamLocation>^St.OpenAi.MsD43E.AudioSegmentsS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
