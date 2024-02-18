Class Demo.DT.ImageToOpenAiImage Extends Ens.DataTransformDTL [ DependsOn = (Demo.Msg.ImageRequest, Banksia.OpenAi.Msg.Images.Request) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.Msg.ImageRequest' targetClass='Banksia.OpenAi.Msg.Images.Request' create='new' language='objectscript' >
<assign value='source.Prompt' property='target.Prompt' action='set' />
<assign value='source.NumImage' property='target.NumOfImages' action='set' />
<assign value='$CASE(source.Size,"S":"256x256","M":"512x512","L":"1024x1024",:"1024x1024")' property='target.Size' action='set' />
<assign value='$CASE(source.Base64,1:"b64_json",:"url")' property='target.ResponseFormat' action='set' />
<assign value='$CASE(source.Operation,"CREATE":"generations", "EDIT":"edits", "VARIATION":"variations",:"generations") ' property='target.Operation' action='set' />
<assign value='source.Image' property='target.Image' action='set' />
<assign value='source.Mask' property='target.Mask' action='set' />
</transform>
}

}
