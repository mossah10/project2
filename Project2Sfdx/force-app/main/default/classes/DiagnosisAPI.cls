/**
 * Created by gamedevmadeeasy on 10/29/19.
 */

public class DiagnosisAPI {
    public static List<ConditionObject> getConditions(Integer age, String sex, List<String> symptoms) {
        
        List<ConditionObject> possibleConditions = new List<ConditionObject>();
        
        // API requires that sex must be 'male' or 'female'
        String querySex = (sex == 'other') ? 'female' : sex;        
        // API requires that age must be a positive integer between 0 and 130
        Integer queryAge = (0 < age && age < 130) ? age : 20;
        
        // Set the endpoint
        String authURL = ('https://api.infermedica.com/v2/diagnosis');
        // Set HTTP Request Type
        String requestMethod = ('POST');
        
        // Set the body
        Map<String, Object> body = new Map<String, Object>();
        List<Map<String, Object>> evidence = new List<Map<String, Object>>();
        
        for (String symptomId : symptoms) {
            Map<String, Object> symptomObj  = new Map<String, Object>();
            symptomObj.put('choice_id', 'present');
            symptomObj.put('id', symptomId);
            evidence.add(symptomObj);
        }
        
        body.put('evidence', evidence);
        body.put('age', queryAge);
        body.put('sex', querySex);
        
        System.debug('body: ' + body);
		String bodyJSON = JSON.serialize(body);
        System.debug('bodyJSON: ' + bodyJSON);
        
        HttpResponse response = APICallout.setupHttpCalloutWithResponse(authURL, requestMethod, bodyJSON);
        System.debug('response: ' + response);
        
        if (response.getStatusCode() == 200) {
            System.debug('responseBody: ' + response.getBody());
            
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        	System.debug('results: ' + results);
            List<Object> conditions = (List<Object>)results.get('conditions');
            System.debug('conditions: ' + conditions);
            
            for (Object cond : conditions) {
                // Map<String, Object> conditionInfo = new Map<String,Object>();
                Map<String, Object> condMap = (Map<String, Object>)cond;
                // conditionInfo.put('Name', (String)condMap.get('name'));
                // conditionInfo.put('Probability', (Double)condMap.get('probability'));

                ConditionObject condition = new ConditionObject();
                condition.setName((String)condMap.get('name'));
                condition.setProbability((Double)condMap.get('probability'));
            
				// System.debug('conditionInfo: ' + conditionInfo);
                possibleConditions.add(condition);
            }
        }
        
        System.debug('possibleConditions: ' + possibleConditions);
        return possibleConditions;
    }
}