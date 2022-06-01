public Without Sharing class Demo12CallingApexController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        return [SELECT Id,Name,Active__c
                FROM
                Account
               ];
    }
  
    @AuraEnabled
    public static List<Contact> getContacts(Id accountId){
        List<Contact> contactList = new List<Contact>();
        contactList = [SELECT Id,Name
               FROM Contact
               WHERE AccountId =:accountId
               AND AccountId != NULL];
            //    System.assert(false);
        return contactList;
    }
  
  
 }
 