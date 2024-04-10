Class St.OpenAi.Msg.Audio.SpeachResponse Extends St.OpenAi.Msg.Api.Response
{

/// Content of the audio response. The answer is a stream. You can convert it acording to the return_type parameter of request.
Property Content As %String(%JSONFIELDNAME = "content", MAXLEN = "");

/// The format to audio in
Property ResponseFormat As %String(%JSONFIELDNAME = "response_format");

Storage Default
{
<Data name="SpeachResponseDefaultData">
<Subscript>"SpeachResponse"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
<Value name="2">
<Value>ResponseFormat</Value>
</Value>
</Data>
<DefaultData>SpeachResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
