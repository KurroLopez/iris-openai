Class St.OpenAi.Model.ListModel Extends St.OpenAi.Base.ApiResult
{

/// List of models
Property Data As list Of St.OpenAi.Model.Model(%JSONFIELDNAME = "data", XMLPROJECTION = "ELEMENT");

/// Object
Property Obj As %String(%JSONFIELDNAME = "object", MAXLEN = "");

}
