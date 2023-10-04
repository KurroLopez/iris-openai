Class Demo.DT.AudioToOpenAiAudio Extends Ens.DataTransformDTL [ DependsOn = (Demo.Msg.AudioRequest, St.OpenAi.Msg.Audio.AudioRequest) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='Demo.Msg.AudioRequest' targetClass='St.OpenAi.Msg.Audio.AudioRequest' create='new' language='objectscript' >
<assign value='source.Audio' property='target.Audio' action='set' />
<assign value='source.Type' property='target.Type' action='set' />
<assign value='source.Language' property='target.Language' action='set' />
<assign value='$CASE(source.Operation,"TRANSCRIPTION":"transcription", "TRANSLATION":"translation",:"transcription") ' property='target.Operation' action='set' />
<if condition='source.FullInfo' >
<true>
<assign value='"verbose_json"' property='target.ResponseFormat' action='set' />
</true>
<false>
<assign value='"json"' property='target.ResponseFormat' action='set' />
</false>
</if>
</transform>
}

}
