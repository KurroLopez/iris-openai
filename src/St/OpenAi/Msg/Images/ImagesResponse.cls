Class St.OpenAi.Msg.Images.ImagesResponse Extends St.OpenAi.Msg.Api.Response
{

/// List of results of the embedding
Property Data As list Of St.OpenAi.Msg.Images.ImagesData(%JSONFIELDNAME = "data");

Storage Default
{
<Data name="ImagesResponseDefaultData">
<Subscript>"ImagesResponse"</Subscript>
<Value name="1">
<Value>Data</Value>
</Value>
</Data>
<DefaultData>ImagesResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
