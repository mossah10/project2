/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class DiagnosisAPI {

    public DiagnosisModel diagnosisMod {get; set;}
    public List<EvidenceModel> evidenceModel {get; set;}
    public List<DiagnosisModel> diagnosisModels {get; set;}

    /*
    * The constructor gets all of the results from the Search Results list
    * and populates the diagnosis model with those results, which we need for
    * converting all of the data into a JSON file that the API calls for.
    */
    public DiagnosisAPI() {
        SearchResults results = new SearchResults();
        for(SearchModel model : results.wrapClassList) {
            EvidenceModel evidence = new EvidenceModel();
            evidence.choice_id = model.Id;
            evidenceModel.add(evidence);
        }
    }

    /**
    * Serializes string data from a List into JSON format
    * @param  List<DiagnosisModel> takes the diagnosis list to create JSON out of
    * @return the data is returned as JSON format.
    */
    private String parseToJsonString(List<DiagnosisModel> diagnosisData) {
        JSONGenerator generator = JSON.createGenerator(false);
        for(DiagnosisModel diag : diagnosisData) {
            diag = new DiagnosisModel();
            generator.writeStartObject();
            generator.writeStringField('sex', diag.Sex);
            generator.writeNumberField('age', diag.Age);
            generator.writeFieldName('Evidence');
            generator.writeStartArray();
            for(EvidenceModel evidence : diag.evidence) {
                generator.writeStringField('id', evidence.id);
                generator.writeStringField('choice_id', evidence.choice_id);
            }
            generator.writeEndArray();
            generator.writeEndObject();
        }
        return generator.getAsString();
    }

    /**
    * Initiates the HTTP Request and requests for the response
    * @return the response from the HTTP request.
    */
    private HttpResponse setupHttpCallout(){
        String AppId = 'c1e5a7d6';
        String AppKey = 'f9cd32e19f27f7c72e91369d0b2d947c';
        HttpResponse response = new HttpResponse();
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        String auth_url = 'https://api.infermedica.com/v2/diagnose';
        req.setMethod('POST');

        req.setHeader('Accept', 'application/json');
        req.setHeader('App-Id', AppId);
        req.setHeader('App-Key', AppKey);
        req.setEndpoint(auth_url);
        req.setBody(parseToJsonString(diagnosisModels));
        return response = http.send(req);
    }
}