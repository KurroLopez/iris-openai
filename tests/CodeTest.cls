Class tests.CodeTest
{

Parameter ApiKey = "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";

Parameter Organization = "org-UAoCnffwAYPX1Y7Ribk84pd1";

/// Test
ClassMethod ValidateAuth() As %Status
{
    set auth = ##class(St.OpenAi.ApiAuthentication).%New(..#ApiKey, ..#Organization)
    set result = auth.ValidateApiKey()
    quit $$$OK
}

}
