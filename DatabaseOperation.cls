public class DatabaseOperation {
    
    // to delete the record, id is required
    public void deleteRecords(){
        List<Account> accountDeleteList = new List<Account>();
        accountDeleteList = [SELECT Id
                             FROM Account 
                             WHERE Name LIKE 'Test Account%'];
        if(accountDeleteList.size() > 0){
            delete accountDeleteList;
        }
    }

    
     // update the records , to update the records Id is always required
    public void updateRecords(){
        List<Account> accountUpdateList = new List<Account>();
        for(Account acc : [SELECT Id,Name,AccountNumber,OwnerId,Active__c,
                           AnnualRevenue,Description,Industry,Phone,Rating 
                           FROM Account 
                           WHERE Active__c = 'Yes'
                           AND Industry != NULL
                           LIMIT 20
                           OFFSET 2]){
                               acc.Active__c = 'No';
                               accountUpdateList.add(acc);
                               // update acc; // NEVER WRITE DML IN LOOP
                           }
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
            for(Account acc : accountUpdateList){
                System.debug('::::'+acc.Id+' '+acc.Active__c);
            }
        }
    }

    
    
    // Read the  records from the database
      public void readRecords(){
        List<Account> accountList = [SELECT Id,Name,AccountNumber,OwnerId,Active__c,
                                     AnnualRevenue,Description,Industry,Phone,Rating 
                                     FROM Account 
                                     WHERE Active__c = 'Yes'
                                     AND Industry != NULL
                                     LIMIT 20
                                     OFFSET 10];
          for(Account acc : accountList){
              System.debug('The Id is '+acc.Id + '>>>>Account name is '+acc.Name);
          }
          
          
          // Alternate way of writing the above code 
          for(Account acc : [SELECT Id,Name,AccountNumber,OwnerId,Active__c,
                             AnnualRevenue,Description,Industry,Phone,Rating 
                             FROM Account 
                             WHERE Active__c = 'Yes'
                             AND Industry != NULL
                             LIMIT 20
                             OFFSET 10000]){
                                 System.debug('Alternate Way : The Id is '+acc.Id + '>>>>Account name is '+acc.Name);
                             }
          
          
      

        
    }

    
    
    
    // creating  single record for an object
    public void  creatsSingleRecord(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Active__c='Yes';
        acc.Industry = 'Biotechnology';
        acc.Description = 'test desctiption';
        Date myDate = Date.newInstance(1960, 2, 17);
        acc.SLAExpirationDate__c = myDate;
        insert acc;
        System.debug('Test Account id is '+acc.Id);
    }
    
    public void createMultipleRecords(){
        for(Integer i=1;i<=50;i++){
            Account acc = new Account();
            acc.Name = 'Test Account '+i;
            acc.Active__c='Yes';
            acc.Industry = 'Biotechnology';
            acc.Description = 'tes';
            Date myDate = Date.newInstance(1960, 2, 17);
            acc.SLAExpirationDate__c = myDate;
            insert acc;
            System.debug('Test Account id is '+i+' ' +acc.Id);
        }
    }


    
    
    

}