/// 
Class Demo.BP.Chat Extends Ens.BusinessProcessBPL
{

Storage Default
{
<Type>%Storage.Persistent</Type>
}

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.Msg.ChatRequest' response='Demo.Msg.ChatResponse' includes='St.OpenAi.OpenAi' height='2000' width='2000' >
<context>
<property name='MsgChatRequest' type='St.OpenAi.Msg.Chat.ChatRequest' instantiate='0' />
<property name='MsgChatResponse' type='St.OpenAi.Msg.Chat.ChatResponse' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<code name='Prepare Msg' xpos='200' ypos='250' >
<![CDATA[ set context.MsgChatRequest = ##class(St.OpenAi.Msg.Chat.ChatRequest).%New()
 set context.MsgChatRequest.Model = request.Model
 if context.MsgChatRequest.Model = ""
 {
 set context.MsgChatRequest.Model = $$$ChatGPTTurbo
 }
 
 set context.MsgChatRequest.Temperature = 0.1
 set context.MsgChatRequest.MaxTokens = request.MaxTokens
 if context.MsgChatRequest.MaxTokens = 0
 {
 set context.MsgChatRequest.MaxTokens = 100
 }
 
 set context.MsgChatRequest.CompiledStop = "none"
 set message = ##class(St.OpenAi.Msg.Chat.ChatMessage).%New()
 set message.Role = $$$UserRole
 set message.Content = request.Prompt
 do context.MsgChatRequest.Messages.Insert(message)]]>
</code>
<call name='Call Api' target='St.OpenAi.BO.Api.Connect' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Chat.ChatRequest' >
<assign property="callrequest" value="context.MsgChatRequest" action="set" />
</request>
<response type='St.OpenAi.Msg.Chat.ChatResponse' >
<assign property="context.MsgChatResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call Api' type='all' xpos='200' ypos='450' />
<transform class='Demo.DT.OpenAiChatToChat' source='context.MsgChatResponse' target='response' xpos='200' ypos='550' />
</sequence>
</process>
}

}
