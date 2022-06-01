global class BatchApexDemo  implements Database.Batchable<sObject>{
    
    
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String query = 'SELECT TYPE FROM Account WHERE Name LIKE \'Demo%\'';
        return Database.getQueryLocator(query);
    }
    
    // Execute method will ne called based on number of Reocrds returned
    //  by the (start method / Scope of the batch) timess
    global void execute(Database.BatchableContext bc, List<Account> accList){
        for(Account acc : accList){
            acc.Type = 'Other';
            
        }//end of for
        // update accList
        List <Database.SaveResult> srList =  Database.update(accList, false);
        for(Database.SaveResult  sr : srList){
            if(sr.isSuccess()){
                System.debug(' Id '+sr.getId());
            }else{
                String str ='';
                for(Database.Error  err : sr.getErrors()){
                   str +=err.getMessage()+'\n';
                }
               
                Error_Log__c  log = new Error_Log__c();
                log.Trace__c = str;
                insert log;
            }
        }     
        
        
    }
    
    
    // It will be called after all execution
    global void finish(Database.BatchableContext bc){
        
    }
}