Class Demo.DT.OpenAiSpeachToSpeach Extends Ens.DataTransformDTL [ DependsOn = (St.OpenAi.Msg.Audio.SpeachResponse, Demo.Msg.SpeachResponse) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='St.OpenAi.Msg.Audio.SpeachResponse' targetClass='Demo.Msg.SpeachResponse' create='new' language='objectscript' >
<assign value='source.Content' property='target.Data' action='set' />
<assign value='source.ResponseFormat' property='target.ResponseFormat' action='set' />
</transform>
}

}
