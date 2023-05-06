/// 
Class Demo.BP.Chat Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.StringRequest' response='St.OpenAi.Msg.Chat.ChatResponse' includes='St.OpenAi.OpenAi' height='2000' width='2000' >
<context>
<property name='MsgChat' type='St.OpenAi.Msg.Chat.ChatRequest' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<code name='Prepare Msg' xpos='200' ypos='250' >
<![CDATA[ set context.MsgChat = ##class(St.OpenAi.Msg.Chat.ChatRequest).%New()
 set context.MsgChat.Model = $$$ChatGPTTurbo
 set context.MsgChat.Temperature = 0.1
 set context.MsgChat.MaxTokens = 5
 set message = ##class(St.OpenAi.Msg.Chat.ChatMessage).%New()
 set message.Role = $$$UserRole
 set message.Content = request.StringValue
 do context.MsgChat.Messages.Insert(message)]]>
</code>
<call name='Call Api' target='St.OpenAi.BO.Api.Connect' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Chat.ChatRequest' >
<assign property="callrequest" value="context.MsgChat" action="set" />
</request>
<response type='St.OpenAi.Msg.Chat.ChatResponse' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call Api' type='all' xpos='200' ypos='450' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
