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
<process language='objectscript' request='Ens.Request' response='Ens.Response' includes='St.OpenAi.OpenAi' height='2000' width='2420' >
<sequence xend='200' yend='700' >
<switch name='CheckRequest' xpos='200' ypos='250' xend='200' yend='500' >
<case condition='$classname(request)="Demo.Msg.ImageRequest"' name='Demo.Msg.ImageImageRequest' >
<call name='Create new image' target='Demo.BP.Image' async='1' xpos='200' ypos='400' >
<request type='Demo.Msg.ImageRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Msg.ImageResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="St.OpenAi.Msg.Model.ModelRequest"' name='St.OpenAi.Msg.Model.ModelRequest' >
<call name='Retrieve models' target='St.OpenAi.BO.Api.Connect' async='1' xpos='470' ypos='400' >
<request type='St.OpenAi.Msg.Model.ModelRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='St.OpenAi.Msg.Model.ModelResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.ChatRequest"' name='Demo.Msg.ChatRequest' >
<call name='Create a chat' target='Demo.BP.Chat' async='1' xpos='740' ypos='400' >
<request type='Demo.Msg.ChatRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Msg.ChatResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="St.OpenAi.Msg.Model.ListModelRequest"' name='St.OpenAi.Msg.Model.ListModelRequest' >
<call name='Retrieve all models' target='St.OpenAi.BO.Api.Connect' async='1' xpos='1010' ypos='400' >
<request type='St.OpenAi.Msg.Model.ListModelRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='St.OpenAi.Msg.Model.ListModelResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.AudioRequest"' name='Demo.Msg.AudioRequest' >
<call name='Audio managment' target='Demo.BP.Audio' async='1' xpos='1280' ypos='400' >
<request type='Demo.Msg.AudioRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Msg.AudioResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.SpeachRequest"' name='Demo.Msg.SpeachRequest' >
<call name='Audio Speach' target='Demo.BP.Speach' async='1' xpos='1550' ypos='400' >
<request type='Demo.Msg.SpeachRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Msg.SpeachResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<case condition='$classname(request)="Demo.Msg.ModerationRequest"' name='Demo.Msg.ModerationRequest' >
<call name='Moderation' target='Demo.BP.Moderation' async='1' xpos='1550' ypos='400' >
<request type='Demo.Msg.ModerationRequest' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Demo.Msg.ModerationResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<default>
<empty name='Do nothing' xpos='1820' ypos='400' />
</default>
</switch>
<sync name='Wait calls' calls='Create new image,Retrieve models,Create a chat,Retrieve all models,Audio managment,Audio Speach,Moderation' type='all' xpos='200' ypos='600' />
</sequence>
</process>
}

}
