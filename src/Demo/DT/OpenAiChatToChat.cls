Class Demo.DT.OpenAiChatToChat Extends Ens.DataTransformDTL [ DependsOn = (St.OpenAi.Msg.Chat.ChatResponse, Demo.Msg.ChatResponse) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='St.OpenAi.Msg.Chat.ChatResponse' targetClass='Demo.Msg.ChatResponse' create='new' language='objectscript' >
<assign value='source.Choices.(1).Message.Content' property='target.Content' action='set' />
</transform>
}

}
