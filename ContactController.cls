public with sharing class ContactController {

    @AuraEnabled(cacheable= true)
    public static List<Contact> getContact(){
        return [SELECT Id,Name,Title,Email,Phone
                FROM Contact
                LIMIT 10];
    }


    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByMailingCountry(String mailingCountry){
    
       return [SELECT Name, Title,Email,Phone, MailingCity, MailingCountry
               FROM Contact WHERE MailingCountry =:mailingCountry];
    }



    @AuraEnabled(cacheable =true)
    public static List<Contact> getLocations(){

        return [SELECT Id , MailingCity , MailingCountry
                FROM Contact
                 WHERE MailingCity != NULL AND MailingCountry != NULL];
        
    }
    
}