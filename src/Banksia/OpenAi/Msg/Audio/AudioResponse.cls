Class Banksia.OpenAi.Msg.Audio.AudioResponse Extends Banksia.OpenAi.Msg.Api.Response
{

/// Task name
Property Task As %String(%JSONFIELDNAME = "task", MAXLEN = "");

/// Language of the audio
Property Language As %String(%JSONFIELDNAME = "language", MAXLEN = "");

/// Duration of the audio
Property Duration As %Decimal(%JSONFIELDNAME = "duration");

/// The text of the transcription/translate
Property Text As %String(%JSONFIELDNAME = "text", MAXLEN = "");

/// Info about toknes, compression ratio, etc..
Property Segments As list Of Banksia.OpenAi.Msg.Audio.AudioSegments(%JSONFIELDNAME = "segments", XMLPROJECTION = "ELEMENT");

Storage Default
{
<Data name="AudioResponseDefaultData">
<Subscript>"AudioResponse"</Subscript>
<Value name="1">
<Value>Text</Value>
</Value>
<Value name="2">
<Value>Task</Value>
</Value>
<Value name="3">
<Value>Language</Value>
</Value>
<Value name="4">
<Value>Duration</Value>
</Value>
<Value name="5">
<Value>Segments</Value>
</Value>
</Data>
<DefaultData>AudioResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
