Class St.OpenAi.Msg.Moderation.Category Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, 
/// nationality, sexual orientation, disability status, or caste. Hateful content aimed at 
/// non-protected groups (e.g., chess players) is harassment
Property Hate As %Boolean(%JSONFIELDNAME = "hate");

/// Hateful content that also includes violence or serious harm towards the targeted group based on race, 
/// gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
Property HateThreatening As %Boolean(%JSONFIELDNAME = "hate/threatening");

/// Content that expresses, incites, or promotes harassing language towards any target.
Property Harassment As %Boolean(%JSONFIELDNAME = "harassment");

/// Harassment content that also includes violence or serious harm towards any target.
Property HarassmentThreatening As %Boolean(%JSONFIELDNAME = "harassment/threatening");

/// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
Property SelfHarm As %Boolean(%JSONFIELDNAME = "self-harm");

/// Content where the speaker expresses that they are engaging or intend to engage in acts of self-harm, 
/// such as suicide, cutting, and eating disorders.
Property SelfHarmIntent As %Boolean(%JSONFIELDNAME = "self-harm/intent");

/// Content that encourages performing acts of self-harm, such as suicide, cutting, and eating disorders, 
/// or that gives instructions or advice on how to commit such acts.
Property SelfHarmInstructions As %Boolean(%JSONFIELDNAME = "self-harm/instructions");

/// Content meant to arouse sexual excitement, such as the description of sexual activity, 
/// or that promotes sexual services (excluding sex education and wellness).
Property Sexual As %Boolean(%JSONFIELDNAME = "sexual");

/// Sexual content that includes an individual who is under 18 years old.
Property SexualMinors As %Boolean(%JSONFIELDNAME = "sexual/minors");

/// Content that depicts death, violence, or physical injury.
Property Violence As %Boolean(%JSONFIELDNAME = "violence");

/// Content that depicts death, violence, or physical injury in graphic detail.
Property ViolenceGraphic As %Boolean(%JSONFIELDNAME = "violence/graphic");

Storage Default
{
<Data name="CategoriesState">
<Value name="1">
<Value>Hate</Value>
</Value>
<Value name="2">
<Value>HateThreatening</Value>
</Value>
<Value name="3">
<Value>Harassment</Value>
</Value>
<Value name="4">
<Value>HarassmentThreatening</Value>
</Value>
<Value name="5">
<Value>SelfHarm</Value>
</Value>
<Value name="6">
<Value>SelfHarmIntent</Value>
</Value>
<Value name="7">
<Value>SelfHarmInstructions</Value>
</Value>
<Value name="8">
<Value>Sexual</Value>
</Value>
<Value name="9">
<Value>SexualMinors</Value>
</Value>
<Value name="10">
<Value>Violence</Value>
</Value>
<Value name="11">
<Value>ViolenceGraphic</Value>
</Value>
</Data>
<State>CategoriesState</State>
<StreamLocation>^St.OpenAi.Msg.MDF76.CategoriesS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
