Class Banksia.OpenAi.Msg.Images.ImagesRequest Extends (Ens.Request, %JSON.Adaptor, %XML.Adaptor)
{

/// Operation of image <br>
/// <ul>
/// <li><b>generations:</b> Create new images according to prompt</li>
/// <li><b>edits:</b> Edit an image and apply a mask, if it's provided, and include a new generation according to prompt</li>
/// <li><b>variations:</b> Create a variation of a image provided acording to prompt</li>
/// </ul>
Property Operation As %String(%JSONINCLUDE = "none", VALUELIST = ",generations,edits,variations");

/// The image to edit. Must be a valid PNG file, less than 4MB, and square. 
/// If mask is not provided, image must have transparency, which will be used as the mask.
Property Image As %String(%JSONFIELDNAME = "image", MAXLEN = "");

/// An additional image whose fully transparent areas (e.g. where alpha is zero) 
/// indicate where image should be edited. 
/// Must be a valid PNG file, less than 4MB, and have the same dimensions as image
Property Mask As %String(%JSONFIELDNAME = "mask", MAXLEN = "");

/// A text description of the desired image(s). The maximum length is 1000 characters.
Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

/// How many different choices to request for each prompt.  Defaults to 1.
Property NumOfImages As %Integer(%JSONFIELDNAME = "n");

/// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. Optional.
Property User As %String(%JSONFIELDNAME = "user", MAXLEN = "");

/// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024. Defauls to 1024x1024
Property Size As %String(%JSONFIELDNAME = "size", VALUELIST = ",256x256,512x512,1024x1024");

/// The format in which the generated images are returned. Must be one of url or b64_json. Defaults to url.
Property ResponseFormat As %String(%JSONFIELDNAME = "response_format", VALUELIST = ",url,b64_json");

Storage Default
{
<Data name="ImagesRequestDefaultData">
<Subscript>"ImagesRequest"</Subscript>
<Value name="1">
<Value>Operation</Value>
</Value>
<Value name="2">
<Value>Image</Value>
</Value>
<Value name="3">
<Value>Mask</Value>
</Value>
<Value name="4">
<Value>Prompt</Value>
</Value>
<Value name="5">
<Value>NumOfImages</Value>
</Value>
<Value name="6">
<Value>User</Value>
</Value>
<Value name="7">
<Value>Size</Value>
</Value>
<Value name="8">
<Value>ResponseFormat</Value>
</Value>
</Data>
<DefaultData>ImagesRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
