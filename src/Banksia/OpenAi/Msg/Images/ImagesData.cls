Class Banksia.OpenAi.Msg.Images.Data Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// The url of the image result
Property Url As %String(%JSONFIELDNAME = "url", MAXLEN = "");

/// The base64-encoded image data as returned by the API
Property Base64 As %String(%JSONFIELDNAME = "b64_json", MAXLEN = "");

Storage Default
{
<Data name="ImagesDataState">
<Value name="1">
<Value>Url</Value>
</Value>
<Value name="2">
<Value>Base64</Value>
</Value>
</Data>
<State>ImagesDataState</State>
<StreamLocation>^Banksia.OpenAi.Msg.ID052.ImagesDataS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
