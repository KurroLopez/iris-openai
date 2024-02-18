Class Demo.DT.OpenAiIAudioToAudio Extends Ens.DataTransformDTL [ DependsOn = (Banksia.OpenAi.Msg.Audio.AudioResponse, Demo.Msg.AudioResponse) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Banksia.OpenAi.Msg.Audio.AudioResponse' targetClass='Demo.Msg.AudioResponse' create='new' language='objectscript' >
<assign value='source.Task' property='target.Task' action='set' />
<assign value='source.Language' property='target.Language' action='set' />
<assign value='source.Duration' property='target.Duration' action='set' />
<assign value='source.Text' property='target.Text' action='set' />
</transform>
}

}
