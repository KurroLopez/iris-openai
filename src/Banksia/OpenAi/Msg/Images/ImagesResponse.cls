Class Banksia.OpenAi.Msg.Images.Response Extends Banksia.OpenAi.Msg.Api.Response
{

/// List of results of the embedding
Property Data As list Of Banksia.OpenAi.Msg.Images.Data(%JSONFIELDNAME = "data");

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
