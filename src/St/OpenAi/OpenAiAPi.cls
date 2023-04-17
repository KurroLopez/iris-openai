Class St.OpenAi.OpenAiAPi
{

/// Base url for OpenAI
/// for OpenAI, should be "https://api.openai.com/{0}/{1}"
Property ApiUrlFormat As %String(MAXLEN = "");

/// Version of Rest API
Property ApiVersion As %String;

/// The API authentication information to use for API calls
Property Auth As ApiAuthentication;

}
