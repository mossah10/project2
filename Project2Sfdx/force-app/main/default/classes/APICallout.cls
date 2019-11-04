/**
 * Created by gamedevmadeeasy on 11/1/19.
 */

public class APICallout {

    /**
    * Initiates the HTTP Request and requests for the response from the outside server.
    * @param AppKey The API Key for accessing the data from the infermedica api.
    * @param AppId The API ID for accessing the data from the infermedica api.
    * @param getPost Specifies whether this is a get or post request.
    * @param auth_url Specify the URL that you wish to use for the request.
    * @param jsonBody is the body of the post request
    * @return the response from the HTTP request.
    */
    public static HttpResponse setupHttpCalloutWithResponse(String auth_url, String getPost, String jsonBody){
        HttpResponse response = new HttpResponse();
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod(getPost);

        req.setHeader('Content-Type', 'application/json');
        req.setHeader('App-Id', APILoginInfo.APIID());
        req.setHeader('App-Key', APILoginInfo.APIKey());
        req.setEndpoint(auth_url);
        req.setBody(jsonBody);
        return response = http.send(req);
    }

    /**
    * @param AppKey The API Key for accessing the data from the infermedica api.
    * @param AppId The API ID for accessing the data from the infermedica api.
    * @param getPost Specifies whether this is a get or post request.
    * @param auth_url Specify the URL that you wish to use for the request.
    * @param Phrase is the search parameter needed for returning results from the Search API.
    */
    public static HttpResponse setupHttpCallout(String auth_url, String getPost, String Phrase) {
        HttpResponse response = new HttpResponse();
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod(getPost);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('App-Id', APILoginInfo.APIID());
        req.setHeader('App-Key', APILoginInfo.APIKey());
        req.setEndpoint(auth_url+Phrase);
        return response = http.send(req);
    }
}