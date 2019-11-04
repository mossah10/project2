/**
 * Created on 10/27/19.
 */


public with sharing class GetSymptomsController {
    List<String> selectedSymptoms = new List<String>();
    public Integer age {get; set;}
    public String gender {get; set;}
    //public Datetime appointmentDate {get; set;}
    public Appointment__c newAppointment {get; set;}
    //public Doctor__c doctor {get; set;}
    public List<ConditionObject> possibleConditions {get; set;}

    public GetSymptomsController() {
        newAppointment = new Appointment__c();
    }

    public List<String> getSelectedSymptoms() {
        return selectedSymptoms;
    }

    public void setSelectedSymptoms(List<String> selectedSymptoms) {
        this.selectedSymptoms = selectedSymptoms;
    }

    public List<SelectOption> getDoc() {
        List<SelectOption> myDoctor = new List<SelectOption>();
        for(Doctor__c doc : [select Name from Doctor__c]) {
            myDoctor.add(new SelectOption(doc.Id, doc.Name));
        }
        return myDoctor;      
    }

    // public List<ConditionObject> getPossibleCondition() {
    //     return possibleConditions;
    // }

    // public void setPossibleCondition(List<ConditionObject> possibleConditions) {
    //     this.possibleConditions = possibleConditions;
    // }
    
    // send list of conditions to appointments, insert Appointment__c.Conditions__c pageref AppointmentDate.page

    public List<SelectOption> getSymptoms() {
        List<SelectOption> mySymptoms = new List<SelectOption>();
        
        for(Symptom__c symptoms : [select Name, apiValue__c from Symptom__c]) {
            mySymptoms.add(new SelectOption(symptoms.apiValue__c, symptoms.Name));
        }
        return mySymptoms;    
    }

    public PageReference getListOfConditions() {
        possibleConditions = DiagnosisAPI.getConditions(age, gender, selectedSymptoms);
        
        return Page.AppointmentDate;
    }

    public PageReference bookAppointment() {
        String patientsPossibleConditions = '';

        for (ConditionObject con : possibleConditions) {
            patientsPossibleConditions += con.getName() + '\n';
        }

        // newAppointment.AppointmentDate__c = appointmentDate;
        //newAppointment.Doctor__c = doctor.Id;
        newAppointment.Conditions__c = patientsPossibleConditions;
    
        insert newAppointment;
        // try {
        //     insert newAppointment;
        // } catch(System.DMLException e) {
        //     ApexPages.addMessages(e);
        //     return null;
        // }
        //  After successful Save, navigate to the default view page
        return new ApexPages.StandardController(newAppointment).save();
    }
}