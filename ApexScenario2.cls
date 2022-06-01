public class ApexScenario2 {
    public void createMapUsingChild(){
        // this approach will only give the accounts which have contact associated with it
        Map<Id,List<Contact>> accountIdToContactMap = new Map<Id,  List<Contact>>();
        for(Contact con : [SELECT Id,Name,AccountId 
                           FROM Contact]){
                               if(!accountIdToContactMap.containsKey(con.AccountId)){
                                   accountIdToContactMap.put(con.AccountId,new List<Contact>());
                               }
                               accountIdToContactMap.get(con.AccountId).add(con);
                               //		List<Contact> tempList = accountIdToContactMap.get(con.AccountId);
                               //		tempList.add(con);
                               
                           }
        for(Id accountId : accountIdToContactMap.keySet()){
            List<Contact> tempContactList = accountIdToContactMap.get(accountId);
            String allContact = '';
            for(Contact con : tempContactList){
                allContact = allContact + con.Name + ' ; ';
            }
            System.debug('For Account '+accountId+' Total Contacts are : '
                         +tempContactList.size() +' Contact values : '+allContact);
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public void createMapUsingParent(){
        
        
        
        
        
        
        
        
        Map<Id, List<Contact>> accountIdToContact = new Map<Id, List<contact>>();
        
        Map<Id,Account> accountIdToName = new Map<Id,Account> ();
        for(Account acc : [Select Id,Name,
                           (Select Id, Name From Contacts)
                           From Account]){
                               if( acc.Contacts.size()>0)
                               {
                                   accountIdToContact.put(acc.id, acc.Contacts); 
                                  
                               }
                           }
        
        for(Id accountId: accountIdToContact.keySet()){
            List<Contact> tempContactList = accountIdToContact.get(accountId);
            String allContacts = '';
            if(tempContactList.size()>0){
                for(Contact con: tempContactList){
                    allContacts +=con.Name + ',';
                }
                
                System.debug('For Account '+ accountId + ' Total Contacts are : '+tempContactList.size()+' Contact values '+ allContacts);     
            }else{  
                System.debug('For Account '+ accountId + ' Total Contacts are : '+tempContactList.size()+' Contact values '+ allContacts);      
            }
        }
        
    }
}