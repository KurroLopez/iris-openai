Class Demo.DT.OpenAiImageToImage Extends Ens.DataTransformDTL [ DependsOn = (Banksia.OpenAi.Msg.Images.ImagesResponse, Demo.Msg.ImageResponse) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Banksia.OpenAi.Msg.Images.ImagesResponse' targetClass='Demo.Msg.ImageResponse' create='new' language='objectscript' >
<foreach property='source.Data()' key='k1' >
<if condition='source.Data.(k1).Url = ""' >
<true>
<assign value='source.Data.(k1).Base64' property='target.Data.(k1)' action='set' />
</true>
<false>
<assign value='source.Data.(k1).Url' property='target.Data.(k1)' action='set' />
</false>
</if>
</foreach>
</transform>
}

}
