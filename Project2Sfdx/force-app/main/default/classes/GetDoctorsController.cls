/**
 * Created on 10/27/19.
 */


public with sharing class GetDoctorsController {
    GetSymptomsController customController = null;

    public GetDoctorsController(GetSymptomsController customController) {
      this.customController = customController;
    }

    public List<SelectOption> getDoc() {
        List<SelectOption> myDoctor = new List<SelectOption>();
        for(Doctor__c doc : [select Name from Doctor__c]) {
            myDoctor.add(new SelectOption(doc.Id, doc.Name));
        }
        return myDoctor;      
    }
}