Class Banksia.OpenAi.Msg.Audio.AudioRequest Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

/// Operation of audio <br>
/// <ul>
/// <li><b>transcription:</b> Retrieve the transcription of the audio file</li>
/// <li><b>translation:</b> Retrieve the translation to other language</li>
/// </ul>
Property Operation As %String(%JSONINCLUDE = "none", VALUELIST = ",translation,transcription") [ Required ];

/// The audio file object (not file name) to transcribe, in one of these formats:
/// flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. (MAX 25Mb)
Property Audio As %String(%JSONFIELDNAME = "file", MAXLEN = "") [ Required ];

/// The type of the file. It's important to create the content-type to send the file
/// flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
Property Type As %String(%JSONFIELDNAME = "type", MAXLEN = "", VALUELIST = ",flac,mp3,mp4,mpeg,mpga,m4a,ogg,wav,webm") [ Required ];

/// An optional text to guide the model's style or continue a previous audio segment. 
/// For transcription, The prompt should match the audio language.
/// For translation, The prompt should be in English.
Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

/// The format of the transcript or translation output. 
/// Must be one of json, text, srt, verbose_json, or vtt. Defaults to url.
Property ResponseFormat As %String(%JSONFIELDNAME = "response_format", VALUELIST = ",json,verbose_json") [ InitialExpression = "json" ];

/// The sampling temperature, between 0 and 1. 
/// Higher values like 0.8 will make the output more random, 
/// while lower values like 0.2 will make it more focused and deterministic. 
/// If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
Property Temperature As %Double(%JSONFIELDNAME = "temperature");

/// The language of the input audio. Supplying the input language in ISO-639-1 format will improve accuracy and latency.
Property Language As %String(%JSONFIELDNAME = "language", MAXLEN = 2);

/// Name of the mmodel, default value should be whisper-1
Property Model As %String(%JSONFIELDNAME = "model", MAXLEN = "") [ InitialExpression = "whisper-1" ];

Storage Default
{
<Data name="AudioRequestDefaultData">
<Subscript>"AudioRequest"</Subscript>
<Value name="1">
<Value>Operation</Value>
</Value>
<Value name="2">
<Value>Audio</Value>
</Value>
<Value name="3">
<Value>Prompt</Value>
</Value>
<Value name="4">
<Value>ResponseFormat</Value>
</Value>
<Value name="5">
<Value>Temperature</Value>
</Value>
<Value name="6">
<Value>Language</Value>
</Value>
<Value name="7">
<Value>Model</Value>
</Value>
<Value name="8">
<Value>AudioFileName</Value>
</Value>
<Value name="9">
<Value>Type</Value>
</Value>
</Data>
<DefaultData>AudioRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
