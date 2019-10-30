/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class DiagnosisAPI {
    public DiagnosisModel diagnosisMod {get; set;}
    public List<DiagnosisModel> diagnosisModels {get; set;}

    /**
    * Deserializes JSON results into a list.
    * @param  json the response.getbody parameter
    * @return the JSON results as a list
    */
    private List<DiagnosisModel> parse(String json) {
        return (List<DiagnosisModel>) System.JSON.deserialize(json, List<DiagnosisModel>.class);
    }

    /**
    * Initiates the HTTP Request and requests for the response
    * @param  Phrase a string value for the phrase needed to get results from the API
    * @return the response from the HTTP request.
    */
    private HttpResponse setupHttpCallout(){
        HttpResponse response = new HttpResponse();
        String AppId = 'c1e5a7d6';
        String AppKey = 'f9cd32e19f27f7c72e91369d0b2d947c';
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        String auth_url = 'https://api.infermedica.com/v2/diagnose';
        req.setMethod('POST');

        req.setHeader('Accept', 'application/json');
        req.setHeader('App-Id', AppId);
        req.setHeader('App-Key', AppKey);
        req.setEndpoint(auth_url);
        return response = http.send(req);
    }

    /**
    * Gets the response data and returns it as a list
    * @param  sex The sex of the patient. Male, Female or both
    * @param  age The age of the patient. Cannot be negative value or 0.
    * @param  evidence List of evidences that will narrow down the diagnosis results.
    * @return the JSON results as a list that can be displayed on a page.
    */
    public List<DiagnosisModel> getHttpResponseData(String sex, Integer age, List<EvidenceModel> evidence) {
        HttpResponse response = setupHttpCallout();
        diagnosisModels = new List<DiagnosisModel>();

        if (response.getStatusCode() == 200) {
            for (DiagnosisModel diag : parse(response.getBody())) {
                diag = new DiagnosisModel();
                diag.Sex = sex;
                if (diag.Age > 0) {
                    diag.Age = age;
                }
                diag.evidence = evidence;
                diagnosisModels.add(diag);
            }
        }
        return diagnosisModels;
    }
}