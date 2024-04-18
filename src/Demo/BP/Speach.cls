/// 
Class Demo.BP.Speach Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Demo.Msg.SpeachRequest' response='Demo.Msg.SpeachResponse' height='2000' width='2000' >
<context>
<property name='speachRequest' type='St.OpenAi.Msg.Audio.SpeachRequest' instantiate='0' />
<property name='speachResponse' type='St.OpenAi.Msg.Audio.AudioRequest' instantiate='0' />
</context>
<sequence xend='200' yend='650' >
<transform name='Audio to OpenAi audio' class='Demo.DT.SpeachToOpenAiSpeach' source='request' target='context.speachRequest' xpos='200' ypos='250' />
<call name='Call API' target='St.OpenAi.BO.Api.Connect' async='1' xpos='200' ypos='350' >
<request type='St.OpenAi.Msg.Audio.SpeachRequest' >
<assign property="callrequest" value="context.speachRequest" action="set" />
</request>
<response type='St.OpenAi.Msg.Audio.AudioResponse' >
<assign property="context.speachResponse" value="callresponse" action="set" />
</response>
</call>
<sync name='Wait Call APi' calls='Call API' type='all' xpos='200' ypos='450' />
<transform name='OpenAi audio to Audio' class='Demo.DT.OpenAiSpeachToSpeach' source='context.speachResponse' target='response' xpos='200' ypos='550' />
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
