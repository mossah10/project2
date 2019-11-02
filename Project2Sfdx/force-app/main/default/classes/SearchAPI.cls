/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class SearchAPI {

    /**
    * Deserializes JSON results into a list.
    * @param  json the response.getbody parameter
    * @return the JSON results as a list
    */
    private List<SearchModel> parse(String json) {
        return (List<SearchModel>) System.JSON.deserialize(json, List<SearchModel>.class);
    }

    /**
    * Initiates the HTTP Request and requests for the response
    * @param  Phrase a string value for the phrase needed to get results from the API
    * @return the response from the HTTP request.
    */
    private HttpResponse setupHttpCallout(String Phrase){
        HttpResponse response = new HttpResponse();
        String AppId = 'c1e5a7d6';
        String AppKey = 'f9cd32e19f27f7c72e91369d0b2d947c';
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        String auth_url = 'https://api.infermedica.com/v2/search?phrase=' + Phrase;
        req.setMethod('GET');

        req.setHeader('Accept', 'application/json');
        req.setHeader('App-Id', AppId);
        req.setHeader('App-Key', AppKey);
        req.setHeader('Dev-Mode', 'true');
        req.setEndpoint(auth_url);
        return response = http.send(req);
    }

    /**
    * Gets the response data and returns it as a list
    * @param  wc The class in which we will be iterating over and turning into a list
    * @param  wrapClassList the list of the search model to be iterated over and returned
    * @param  Phrase the string value of the phrase that is being searched for.
    * @return the JSON results as a list that can be displayed on a page.
    */
    public List<SearchModel> getHttpResponseData(SearchModel wc, List<SearchModel> wrapClassList, String Phrase) {
        HttpResponse response = setupHttpCallout(Phrase);
        wrapClassList = new List<SearchModel>();

        if (response.getStatusCode() == 200) {
            for (SearchModel ac : parse(response.getBody())) {
                wc = new SearchModel();
                wc.Flag = false;
                wc.Id = ac.Id;
                wc.Label = ac.Label;
                wrapClassList.add(wc);
            }
        }
        return wrapClassList;
    }
}