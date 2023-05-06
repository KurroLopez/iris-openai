Class Demo.Msg.ImageRequest Extends (Ens.Request, %JSON.Adaptor)
{

/// Prompt of the images to create
Property Prompt As %String(%JSONFIELDNAME = "prompt", MAXLEN = "");

/// Number of images to retrieve.
Property NumImage As %Integer(%JSONFIELDNAME = "number_images");

/// Size of the image, S-Small, M-Medium, L-Large
Property Size As %String(%JSONFIELDNAME = "size", MAXLEN = 1);

/// Retrieve the images in Base64, by default will be retrieved in url
Property Base64 As %Boolean(%JSONFIELDNAME = "base64");

/// Operation
Property Operation As %String(%JSONINCLUDE = "none");

/// The image to edit. Must be a valid PNG file, less than 4MB, and square. 
/// If mask is not provided, image must have transparency, which will be used as the mask.
Property Image As %String(%JSONFIELDNAME = "image", MAXLEN = "");

/// An additional image whose fully transparent areas (e.g. where alpha is zero) 
/// indicate where image should be edited. 
/// Must be a valid PNG file, less than 4MB, and have the same dimensions as image
Property Mask As %String(%JSONFIELDNAME = "mask", MAXLEN = "");

Storage Default
{
<Data name="ImageRequestDefaultData">
<Subscript>"ImageRequest"</Subscript>
<Value name="1">
<Value>Prompt</Value>
</Value>
<Value name="2">
<Value>NumImage</Value>
</Value>
<Value name="3">
<Value>Size</Value>
</Value>
<Value name="4">
<Value>Base64</Value>
</Value>
<Value name="5">
<Value>Operation</Value>
</Value>
<Value name="6">
<Value>Image</Value>
</Value>
<Value name="7">
<Value>Mask</Value>
</Value>
</Data>
<DefaultData>ImageRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
