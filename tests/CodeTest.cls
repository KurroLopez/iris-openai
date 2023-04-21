Class tests.CodeTest
{

Parameter ApiKey = "InsertHereYourApiKey";

Parameter Organization = "InsertHereYourOrganisation";

/// Test
ClassMethod ValidateAuth() As %Status
{
    set auth = ##class(St.OpenAi.ApiAuthentication).%New(..#ApiKey, ..#Organization)
    set result = auth.ValidateApiKey()
    quit $$$OK
}

}
