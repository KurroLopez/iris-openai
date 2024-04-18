Class Demo.Install Extends St.Tools.Deploy
{

// Class with initial instructions

ClassMethod Deploy()
{
        set production = "Demo.Production"
        set currentNamespace = $Namespace
        // Add main paramateres
        do ..AddItem(production, "St.OpenAi.BO.Api.Connect","St.OpenAi.BO.Api.Connect")
        do ..AddItem(production, "Demo.BP.Chat","Demo.BP.Chat")
        do ..AddItem(production, "Demo.BP.Audio","Demo.BP.Audio")
        do ..AddItem(production, "Demo.BP.Speach","Demo.BP.Speach")
        do ..AddItem(production, "Demo.BP.Image","Demo.BP.Image")
        do ..AddItem(production, "Demo.BP.Moderation","Demo.BP.Modeartion")
        do ..AddItem(production, "Demo.BP.OpenAi","Demo.BP.OpenAi")
        do ..AddItem(production, "Demo.BS.API.OpenAi","Demo.BS.API.OpenAi")

        // Add default parameters
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","ApiKey","sk-InsertHereYourApiKey")
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","Organization","org-InsertHereYourOrganizationID")
        do ..AddDefaultSetting(production,,"St.OpenAi.BO.Api.Connect","SSLConfig","OpenAiSSL")

        // Add SSL Certificate
        New $Namespace
        Set $Namespace = "%SYS"
        if ('##class(Security.SSLConfigs).Exists("OpenAiSSL")) set st = ##class(Security.SSLConfigs).Create("OpenAiSSL")

        // Add API Services
        do ..RegisterWebApplication(currentNamespace, "/openai/api","Demo.BS.API.OpenAi")
}

}
