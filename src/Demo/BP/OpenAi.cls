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
<process language='objectscript' request='Ens.Request' response='Ens.Response' includes='Banksia.OpenAi.OpenAi' height='2000' width='2150' >
<sequence xend='200' yend='700' >
<switch name='CheckRequest' xpos='200' ypos='250' xend='200' yend='500' >
<case condition='$classname(request)="Demo.Msg.ImageRequest"' name='Demo.Msg.ImageImageRequest' >
<call name='Create new image' target='Demo.BP.Image' async='1' xpos='200' ypos='400' >
<request type='Demo.Msg.ImageRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Demo.Msg.ImageResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='$classname(request)="Banksia.OpenAi.Msg.Model.ModelRequest"' name='Banksia.OpenAi.Msg.Model.ModelRequest' >
<call name='Retrieve models' target='Banksia.OpenAi.BO.Api.Connect' async='1' xpos='470' ypos='400' >
<request type='Banksia.OpenAi.Msg.Model.ModelRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Banksia.OpenAi.Msg.Model.ModelResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.ChatRequest"' name='Demo.Msg.ChatRequest' >
<call name='Create a chat' target='Demo.BP.Chat' async='1' xpos='740' ypos='400' >
<request type='Demo.Msg.ChatRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Demo.Msg.ChatResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='$classname(request)="Banksia.OpenAi.Msg.Model.ListModelRequest"' name='Banksia.OpenAi.Msg.Model.ListModelRequest' >
<call name='Retrieve all models' target='Banksia.OpenAi.BO.Api.Connect' async='1' xpos='1010' ypos='400' >
<request type='Banksia.OpenAi.Msg.Model.ListModelRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Banksia.OpenAi.Msg.Model.ListModelResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.AudioRequest"' name='Demo.Msg.AudioRequest' >
<call name='Audio managment' target='Demo.BP.Audio' async='1' xpos='1280' ypos='400' >
<request type='Demo.Msg.AudioRequest' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Demo.Msg.AudioResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</case>
<default>
<empty name='Do nothing' xpos='1550' ypos='400' />
</default>
</switch>
<sync name='Wait calls' calls='Create new image,Retrieve models,Create a chat,Retrieve all models,Audio managment' type='all' xpos='200' ypos='600' />
</sequence>
</process>
}

}
