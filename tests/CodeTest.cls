Class tests.CodeTest
{

Parameter ApiKey = "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";

Parameter Organization = "org-UAoCnffwAYPX1Y7Ribk84pd1";

/// Test
ClassMethod ValidateAuth() As %Status
{
    set auth = ##class(St.OpenAi.ApiAuthentication).%New(..#ApiKey, ..#Organization)
    write auth.ValidateApiKey()
}

}
