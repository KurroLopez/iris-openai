Class Demo.DT.SpeachToOpenAiSpeach Extends Ens.DataTransformDTL [ DependsOn = (Demo.Msg.SpeachRequest, St.OpenAi.Msg.Audio.SpeachRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.Msg.SpeachRequest' targetClass='St.OpenAi.Msg.Audio.SpeachRequest' create='new' language='objectscript' >
<assign value='source.Model' property='target.Model' action='set' />
<assign value='source.Prompt' property='target.Prompt' action='set' />
<assign value='source.Voice' property='target.Voice' action='set' />
</transform>
}

}
