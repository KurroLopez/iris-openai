/// 
Class Demo.BP.OpenAi Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' includes='St.OpenAi.OpenAi' height='2000' width='2000' >
<sequence xend='200' yend='700' >
<switch name='CheckRequest' xpos='200' ypos='250' xend='200' yend='500' >
<case condition='$classname(request)="Demo.Msg.ImageRequest"' name='Demo.Msg.ImageResponse' >
<call name='Create new image' target='Demo.BP.Image' async='1' xpos='200' ypos='400' >
<request type='Demo.Msg.ImageRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Demo.Msg.ImageResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<default>
<empty name='Do nothing' xpos='521' ypos='407' />
</default>
</switch>
<sync name='Wait calls' calls='Create new image' type='all' xpos='200' ypos='600' />
</sequence>
</process>
}

}
