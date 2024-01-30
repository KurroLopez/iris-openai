Class St.OpenAi.Msg.Audio.Speach.AudioResponse Extends St.OpenAi.Msg.Api.Response
{

/// Content of the audio response. The answer is a stream. You can convert it acording to the return_type parameter of request.
Property Content As %Stream.GlobalBinary;

Storage Default
{
<Data name="AudioResponseDefaultData">
<Subscript>"AudioResponse"</Subscript>
<Value name="1">
<Value>Content</Value>
</Value>
</Data>
<DefaultData>AudioResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
