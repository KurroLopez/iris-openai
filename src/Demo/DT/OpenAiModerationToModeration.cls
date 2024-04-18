Class Demo.DT.OpenAiModerationToModeration Extends Ens.DataTransformDTL [ DependsOn = (St.OpenAi.Msg.Moderation.ModerationResponse, Demo.Msg.ModerationResponse) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='St.OpenAi.Msg.Moderation.ModerationResponse' targetClass='Demo.Msg.ModerationResponse' create='new' language='objectscript' >
<if condition='source.Result.(1).Flagged' >
<true>
<code>
<![CDATA[ set first = 1]]></code>
<if condition='source.Result.(1).Categories.Hate' >
<true>
<code>
<![CDATA[ set text = "Hate"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.Hate * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.HateThreatening' >
<true>
<code>
<![CDATA[ set text = "Hate threatening"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.HateThreatening * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.Harassment' >
<true>
<code>
<![CDATA[ set text = "Harassment"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.Harassment * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.HarassmentThreatening' >
<true>
<code>
<![CDATA[ set text = "Harassment threatening"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.HarassmentThreatening * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.SelfHarm' >
<true>
<code>
<![CDATA[ set text = "Self harm"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.SelfHarm * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.SelfHarmIntent' >
<true>
<code>
<![CDATA[ set text = "Self harm intent"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.SelfHarmIntent * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.SelfHarmInstructions' >
<true>
<code>
<![CDATA[ set text = "Self harm instructions"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.SelfHarmInstructions * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.Sexual' >
<true>
<code>
<![CDATA[ set text = "Sexual"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.Sexual * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.SexualMinors' >
<true>
<code>
<![CDATA[ set text = "Sexual minors"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.SexualMinors * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.Violence' >
<true>
<code>
<![CDATA[ set text = "Violence"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.Violence * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
<if condition='source.Result.(1).Categories.ViolenceGraphic' >
<true>
<code>
<![CDATA[ set text = "Violence graphic"
 if 'first set text = ", "_text
 set score = source.Result.GetAt(1).CategoryScores.ViolenceGraphic * 100
 set text = text_"("_$FNumber(score, "",2)_"%)"
 set first = 0]]></code>
<assign value='target.Description_text' property='target.Description' action='set' />
</true>
</if>
</true>
<false>
<assign value='"Neutral"' property='target.Description' action='set' />
</false>
</if>
</transform>
}

}
