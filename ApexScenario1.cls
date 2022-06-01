public class ApexScenario1 {
    
    
    public void SolutionUsingMaps(){
        Map<Id,Account> recordIdToRecordMap = new Map<Id,Account>();
        for(Contact con :  [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE Name LIKE 'Contact Demo%'
                            AND AccountId != NULL]){
                                    Account acc = new Account(); 
                                   acc.Id = con.AccountId; 
                                   acc.Active__c = 'Yes';
                                   recordIdToRecordMap.put(acc.Id,acc);
                            }
        
        if(recordIdToRecordMap.size()>0){
            List<Account> accountUpdateList = recordIdToRecordMap.values();
            // Update accountUpdateList;
            update recordIdToRecordMap.values();
        }
    }
    
    
    
    
    public void solutionUsingSet(){
        
        List<Account> accountUpdateList = new List<Account>();
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con : [SELECT Id,Name,AccountId
                           FROM Contact
                           WHERE Name LIKE 'Contact Demo%'
                           AND AccountId != NULL]){
                               // alternate way of updating records 
                               if(!accountIdSet.contains(con.AccountId))
                               {
                                   Account acc = new Account(); // create new instance of account
                                   acc.Id = con.AccountId; // assign new instance account id to contact's account id
                                   acc.Active__c = 'Yes';
                                   accountIdSet.add(con.AccountId);
                                   accountUpdateList.add(acc);   
                               }
                               
                           }
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
        }
        
      
     // Do  not Create Set<SObject>   
       
      /*  Set<Account> accountSet = new Set<Account>();
Set<Id> accountIdSet = new Set<Id>();
Account acc = new Account();
acc.Name = 'test';
insert acc; 
accountSet.add(acc);
accountIdSet.add(acc.Id);
System.debug('Set values are '+accountSet);
System.debug('size of Set is '+accountSet.size());
Account tempAccount = new Account();
tempAccount.Id = acc.Id;
tempAccount.Name = 'Test';
update tempAccount;
System.debug('%%%%%%%%%%%%%%%%%%%%%%'+accountIdSet.contains(tempAccount.Id));
System.debug('=====$$$$$$=========================='+accountSet.contains(tempAccount));
System.debug('===============================');
System.debug('Set values are '+accountSet);
System.debug('size of Set is '+accountSet.size());
List<Account> testList = new List<Account>();
testList.addAll(accountSet);
update testList;

        
      */  
        
        
        
    }


    
}