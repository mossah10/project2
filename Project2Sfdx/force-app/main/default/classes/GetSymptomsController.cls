/**
 * Created on 10/27/19.
 */


public with sharing class GetSymptomsController {
    List<String> selectedSymptoms = new List<String>();
    public Integer age {get; set;}
    public String gender {get; set;}
    public List<ConditionObject> possibleConditions {get; set;}

    public List<String> getSelectedSymptoms() {
        return selectedSymptoms;
    }

    public void setSelectedSymptoms(List<String> selectedSymptoms) {
        this.selectedSymptoms = selectedSymptoms;
    }

    // public List<ConditionObject> getPossibleCondition() {
    //     return possibleConditions;
    // }

    // public void setPossibleCondition(List<ConditionObject> possibleConditions) {
    //     this.possibleConditions = possibleConditions;
    // }

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

    public PageReference getListOfConditions() {
        possibleConditions = DiagnosisAPI.getConditions(age, gender, selectedSymptoms);
        return null;
    }
}