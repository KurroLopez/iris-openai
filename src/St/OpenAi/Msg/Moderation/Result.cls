Class St.OpenAi.Msg.Moderation.Result Extends (%SerialObject, %JSON.Adaptor, %XML.Adaptor)
{

/// Whether any of the below categories are flagged.
Property Flagged As %Boolean(%JSONFIELDNAME = "flagged");

/// A list of the categories, and whether they are flagged or not.
Property Categories As St.OpenAi.Msg.Moderation.Category(%JSONFIELDNAME = "categories", XMLPROJECTION = "ELEMENT");

/// A list of the categories along with their scores as predicted by model.
Property CategoryScores As St.OpenAi.Msg.Moderation.CategoryScore(%JSONFIELDNAME = "category_scores", XMLPROJECTION = "ELEMENT");

Storage Default
{
<Data name="ResultState">
<Value name="1">
<Value>Flagged</Value>
</Value>
<Value name="2">
<Value>Categories</Value>
</Value>
<Value name="3">
<Value>CategoryScores</Value>
</Value>
</Data>
<State>ResultState</State>
<StreamLocation>^St.OpenAi.Msg.ModerDF76.ResultS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
