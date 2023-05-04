Class Demo.Install Extends St.Tools.Deploy
{

// Class with initial instructions

ClassMethod Deploy()
{
        set production = "Demo.Production"

        // Add main paramateres
        do ..AddItem(production, "St.OpenAi.BO.Api.Connect","St.OpenAi.BO.Api.Connect")

        // Add default parameters
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","ApiKey","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")
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","Organization","org-UAoCnffwAYPX1Y7Ribk84pd1")
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","SSLConfig","OpenAiSSL")

        // Add SSL Certificate
        New $Namespace
        Set $Namespace = "%SYS"
        if ('##class(Security.SSLConfigs).Exists("OpenAiSSL")) set st = ##class(Security.SSLConfigs).Create("OpenAiSSL")
}

}
