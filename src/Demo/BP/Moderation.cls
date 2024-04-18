/// 
Class Demo.BP.Moderation Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.Msg.ModerationRequest' response='Demo.Msg.ModerationResponse' includes='St.OpenAi.OpenAi' height='2000' width='2000' >
<context>
<property name='ModerationRequest' type='St.OpenAi.Msg.Moderation.ModerationRequest' instantiate='0' />
<property name='ModerationResponse' type='St.OpenAi.Msg.Moderation.ModerationResponse' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<transform name='Moderation to OpenAi Moderation' class='Demo.DT.ModerationToOpenAiModeration' source='request' target='context.ModerationRequest' xpos='200' ypos='250' />
<call name='Call Api' target='St.OpenAi.BO.Api.Connect' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Moderation.ModerationRequest' >
<assign property="callrequest" value="context.ModerationRequest" action="set" />
</request>
<response type='St.OpenAi.Msg.Moderation.ModerationResponse' >
<assign property="context.ModerationResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call Api' type='all' xpos='200' ypos='450' />
<transform name='OpenAi Moderation to Moderation' class='Demo.DT.OpenAiModerationToModeration' source='context.ModerationResponse' target='response' xpos='200' ypos='550' />
</sequence>
</process>
}

}
