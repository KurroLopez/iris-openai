/// 
Class Demo.BP.Image Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.Msg.ImageRequest' response='Demo.Msg.ImageResponse' includes='Banksia.OpenAi.OpenAi' height='2000' width='2000' >
<context>
<property name='imagesRequest' type='Banksia.OpenAi.Msg.Images.Request' instantiate='0' />
<property name='imagesResponse' type='Banksia.OpenAi.Msg.Images.Response' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<transform name='Image to OpenAi image' class='Demo.DT.ImageToOpenAiImage' source='request' target='context.imagesRequest' xpos='200' ypos='250' />
<call name='Call Api' target='Banksia.OpenAi.Operation' async='1' xpos='200' ypos='350' >
<request type='Banksia.OpenAi.Msg.Images.Request' >
<assign property="callrequest" value="context.imagesRequest" action="set" />
</request>
<response type='Banksia.OpenAi.Msg.Images.Response' >
<assign property="context.imagesResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call Api' type='all' xpos='200' ypos='450' />
<transform name='OpenAi image to Image' class='Demo.DT.OpenAiImageToImage' source='context.imagesResponse' target='response' xpos='200' ypos='550' />
</sequence>
</process>
}

}
