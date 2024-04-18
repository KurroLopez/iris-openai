Class Demo.DT.ModerationToOpenAiModeration Extends Ens.DataTransformDTL [ DependsOn = (Demo.Msg.ModerationRequest, St.OpenAi.Msg.Moderation.ModerationRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.Msg.ModerationRequest' targetClass='St.OpenAi.Msg.Moderation.ModerationRequest' create='new' language='objectscript' >
<assign value='source.Prompt' property='target.Input' action='set' />
</transform>
}

}
