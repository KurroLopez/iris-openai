Class St.OpenAi.Msg.Moderation.ModerationResponse Extends St.OpenAi.Msg.Api.Response
{

/// A list of moderation objects.
Property Result As list Of St.OpenAi.Msg.Moderation.Result(%JSONFIELDNAME = "results");

Storage Default
{
<Data name="ModerationResponseDefaultData">
<Subscript>"ModerationResponse"</Subscript>
<Value name="1">
<Value>Result</Value>
</Value>
</Data>
<DefaultData>ModerationResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
