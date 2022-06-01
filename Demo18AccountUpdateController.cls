public with sharing class Demo18AccountUpdateController {
    @AuraEnabled
    public static Account getAccountInfo(String recordId){
       
        return [SELECT Id, Name, Rating 
                FROM Account
                WHERE Id =: recordId];
    }


    @AuraEnabled
    public static string  updateAccountDetails(Account acc){
        try {
            update acc;
            return  'OK';
            
        } catch (Exception e) {
           return 'NOTOK';
        }
    }
    
}
