/**
 * Created by gamedevmadeeasy on 10/27/19.
 */

public class GetAllSymptoms {
    public List<GetAllSymptomsModel> wrapClassList { get; set; }
    public List<GetAllSymptomsModel> excessDataList {get; set;}
    public GetAllSymptomsModel wc { get; set; }

    public PageReference onLoad() {
        HttpResponse response = new HttpResponse();
        wrapClassList = new List<GetAllSymptomsModel>();
        excessDataList = new List<GetAllSymptomsModel>();
        String AppId = 'c1e5a7d6';
        String AppKey = 'f9cd32e19f27f7c72e91369d0b2d947c';
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        // Kind of a cheat, but we are taking the curl's full url and appending the
        // input and sex to it.
        String auth_url = 'https://api.infermedica.com/v2/symptoms';
        req.setMethod('GET');

        req.setHeader('Accept', 'application/json');
        req.setHeader('App-Id', AppId);
        req.setHeader('App-Key', AppKey);
        req.setHeader('Dev-Mode', 'true');
        req.setEndpoint(auth_url);
        response = http.send(req);
        if (response.getStatusCode() == 200) {
            for(GetAllSymptomsModel ac : parse(response.getBody())) {
                wc = new GetAllSymptomsModel();
                wc.flag = false;
                wc.id = ac.id;
                wc.name = ac.name;
                if (WrapClassList.size() < 25) {
                    wrapClassList.add(wc);
                }
                else {
                    excessDataList.add(wc);
                }
            }
        }

        return null;
    }

    public List<GetAllSymptomsModel> parse(String json) {
        return (List<GetAllSymptomsModel>) System.JSON.deserialize(json, List<GetAllSymptomsModel>.class);
    }
}