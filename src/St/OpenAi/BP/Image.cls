/// 
Class St.OpenAi.BP.Image Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.StringRequest' response='St.OpenAi.Msg.Images.ImagesResponse' includes='St.OpenAi.OpenAi' height='2000' width='2000' >
<context>
<property name='MsgImage' type='St.OpenAi.Msg.Images.ImagesRequest' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<code name='Prepare Msg' xpos='200' ypos='250' >
<![CDATA[ set context.MsgImage = ##class(St.OpenAi.Msg.Images.ImagesRequest).%New()
 set context.MsgImage.Prompt = request.StringValue
 set context.MsgImage.Size = $$$ImageSmall
]]>
</code>
<call name='Call Api' target='St.OpenAi.BO.Api.Connect' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Images.ImagesRequest' >
<assign property="callrequest" value="context.MsgImage" action="set" />
</request>
<response type='St.OpenAi.Msg.Images.ImagesResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call Api' type='all' xpos='200' ypos='450' />
</sequence>
</process>
}

}
