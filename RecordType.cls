public class RecordType {
    
    public void utility(){
        
        // code to find the picklist values
        List<String> pickListValuesList= new List<String>();
        Schema.DescribeFieldResult fieldResult = College__c.State__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            //pickListValuesList.add(pickListVal.getLabel());
            System.debug('>>>'+pickListVal.getLabel());
        }  
        
        // get record type
        Id recordTypeId = Schema.SObjectType.Student__c.getRecordTypeInfosByName().get('Graduation').getRecordTypeId();
        System.debug('REcord Type id is '+recordTypeId);

        
    }

}