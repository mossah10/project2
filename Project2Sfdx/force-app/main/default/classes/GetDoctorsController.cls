/**
 * Created on 10/27/19.
 */


public with sharing class GetDoctorsController {
    Public List<Doctor__c> dlist {get; set;}

    


    public GetDoctorsController(ApexPages.StandardController sc) 
	{
		dlist = new List<Doctor__c>();

			dlist = [SELECT Name FROM Doctor__c];
    }


    public List<SelectOption> getDoc {
    get{
        List<SelectOption> myDoctor = new List<SelectOption>();
        for(Doctor__c doc : [select Name from Doctor__c]) {
            myDoctor.add(new SelectOption(doc.Id, doc.Name));
        }
        return myDoctor;      
        }
    set;
    }
}
