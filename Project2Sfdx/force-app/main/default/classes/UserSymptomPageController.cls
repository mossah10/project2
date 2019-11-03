/**
 * Created by gamedevmadeeasy on 11/2/19.
 */

public without sharing class UserSymptomPageController {

    public List<Symptom__c> sympTemp = new List<Symptom__c>();

    public UserSymptomPageController(ApexPages.StandardController sc) {
    }
    public List<SelectOption> getSymptoms {
        get{
        sympTemp = [select Name from Symptom__c];
        getSymptoms = new List<SelectOption>();
        for(Symptom__c sym : sympTemp) {
            getSymptoms.add(new SelectOption(sym.Id, sym.Name));
        }
        return getSymptoms;      
        }
    set;
    }

}