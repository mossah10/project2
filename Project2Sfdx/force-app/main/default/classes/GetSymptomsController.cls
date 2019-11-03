/**
 * Created on 10/27/19.
 */


public with sharing class GetSymptomsController {
    String[] selectedSymptoms = new String[]{};
    public Integer age {get; set;}
    public String gender {get; set;}


    public PageReference test() {
        return null;
    }

    public List<SelectOption> getSymptoms() {
            List<SelectOption> mySymptoms = new List<SelectOption>();
            for(Symptom__c symptoms : [select Name, apiValue__c from Symptom__c]) {
                mySymptoms.add(new SelectOption(symptoms.apiValue__c, symptoms.Name));
            }
            return mySymptoms;    
    }

    public String[] getSelectedSymptoms() {
        return selectedSymptoms;
    }

    public void setSelectedSymptoms(String[] selectedSymptoms) {
        this.selectedSymptoms = selectedSymptoms;
    }
}