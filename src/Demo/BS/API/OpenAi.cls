Class Demo.BS.API.OpenAi Extends (%CSP.REST, Ens.BusinessService)
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
	<Route Url="(?i)/image/create" Method="POST" Call="CreateImage"/>
    <Route Url="(?i)/image/edit" Method="POST" Call="EditImage"/>
    <Route Url="(?i)/image/variation" Method="POST" Call="VariationImage"/>
</Routes>
}

Parameter BPOPENAI = "Demo.BP.OpenAi";

Parameter CLASSBS = "Demo.BS.API.OpenAi";

/// Create an image
ClassMethod CreateImage() As %Status
{
    quit ..RetrieveImage("CREATE")
}

/// Edit an image
ClassMethod EditImage() As %Status
{
    quit ..RetrieveImage("EDIT")
}

/// Variation of an image
ClassMethod VariationImage() As %Status
{
    quit ..RetrieveImage("VARIATION")
}

ClassMethod RetrieveImage(operation As %String) As %Status
{
    set %response.ContentType = "application/json; charset=utf-8"
    set $ZSTORAGE=-1

    do ##class(Ens.Director).CreateBusinessService(..#CLASSBS, .service)

    Try {
        $$$TRACE("Init process")
        set dynamic = ##class(%Library.DynamicObject).%FromJSON(%request.Content)
        set pRequest = ##class(Demo.Msg.ImageRequest).%New()
        do pRequest.%JSONImport(dynamic)
        $$$TRACE("Dynamic created")
        set pRequest.Operation = operation
        $$$TRACE("Calling OpenAi")
        set tSC = service.SendRequestSync(..#BPOPENAI, pRequest, .pResponse)
        $$$ThrowOnError(tSC)
        $$$TRACE("Init process")
        set %response.Status= ..#HTTP200OK
        set %response.CharSet = "utf-8"
        set %response.ContentType = "application/json"
        do pResponse.%JSONExportToStream(.tStream)
        do tStream.OutputToDevice()
    }
    Catch ex {
        Set tSC=ex.AsStatus()
		set errorCode = $system.Status.GetErrorCodes(tSC)
        Set msgError = $System.Status.GetOneStatusText(tSC,1)
        set pError = ##class(%Library.DynamicObject).%New()
        set %response.Status= ..#HTTP200OK
        set %response.CharSet = "utf-8"
        set %response.ContentType = "application/json"
        set pError.code = errorCode
        Set pError.message = msgError
        write pError.%ToJSON()
    }
    
    quit $$$OK
}

Method OnProcessInput(pInput As %RegisteredObject, Output pOutput As %RegisteredObject, ByRef pHint As %String) As %Status
{
	//1: pHint — The configuration name of the business process or business operation to which the request is sent.
	//2: pInput — A request message. See Defining Ensemble Messages.
	//3: pOutput — (By reference) A response message. This object receives the data returned by the response.
	//4: pTimeout — (Optional) The number of seconds to wait for a response. The default is –1 (wait forever).

	Quit ..SendRequestSync(pHint, pInput, .pOutput)
}

}
