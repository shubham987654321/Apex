public class ApexHandlerClass {
    
    
    public static void populateFavColorUpdate(List<Account> newList,Map<Id,Account> oldMap){
        Set<Id> ownerIdSet = new Set<Id>();
       /* for(Account acc : newList){
            for(Account oldAcc : oldList){
                if(acc.Id == oldAcc.Id && acc.ownerId != oldAcc.ownerId){
                    ownerIdSet.add(acc.OwnerId);
                }
            }
        } */
        for(Account acc : newList){
            if(acc.ownerId != oldMap.get(acc.Id).ownerId){
                ownerIdSet.add(acc.OwnerId);
            }
        }    
        if(ownerIdSet.size() > 0){
            Map<Id,String> userIdToFavColor = new  Map<Id,String>();
            for(User usr : [SELECT Id,Favourite_Color__c 
                            FROM User 
                            WHERE Id IN :ownerIdSet]){
                                userIdToFavColor.put(usr.Id,usr.Favourite_Color__c); 
                            }
            for(Account acc : newList){
                if(acc.ownerId != oldMap.get(acc.Id).ownerId){
                        acc.Favourite_Color__c = userIdToFavColor.get(acc.ownerId);
                    }
            }
            System.debug('@@@@@@@@@@@@@');
        }
    }

    
   public static void populateFavouriteColor(List<Account> newList){
        Set<Id> ownerIdSet = new Set<Id>();
        for(Account acc : newList){
            ownerIdSet.add(acc.OwnerId);
        }
        Map<Id,String> userIdToFavColor = new  Map<Id,String>();
        for(User usr : [SELECT Id,Favourite_Color__c
            		   FROM User 
                       WHERE Id IN :ownerIdSet]){
                          userIdToFavColor.put(usr.Id,usr.Favourite_Color__c); 
        }
         for(Account acc : newList){
            acc.Favourite_Color__c = userIdToFavColor.get(acc.ownerId);
        }
    }

    /*
    public static void populateSLAExpirationDate(List<Account> newList){
        for(Account acc : newList){
            acc.SLAExpirationDate__c = Date.today().addDays(180);
            acc.Active__c = 'Yes';  
        }
    }
*/
    
    public static void populateSLAExpirationDate(List<Account> newList){
        for(Account acc : newList){
            acc.SLAExpirationDate__c = Date.today().addDays(180);
            acc.Active__c = 'Yes';  
        }
    }

    
    public static void creteDefaultOpportunity(List<Account> newList){
        List<Opportunity> opportunityList = new List<Opportunity>();
        Id prepaidRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
        for(Account acc : newList){
            Opportunity opp =new Opportunity();
            opp.StageName = 'Prospecting';
            opp.CloseDate = Date.today().addDays(100);
            opp.Name = acc.Name + '- Default Opportunity';
            opp.RecordTypeId = prepaidRecordTypeId;
            opp.AccountId = acc.Id;
            opportunityList.add(opp);
        }
        if(opportunityList.size() > 0){
            insert opportunityList;
        }
    }
    
    public static void populateSLAExpirationDateAfterInsert(List<Account> newList){
        List<Account> accountUpdateList = new List<Account>();
        for(Account acc : newList){
            Account temp = new Account();
            temp.SLAExpirationDate__c = Date.today().addDays(180);
            temp.Active__c = 'Yes';
            temp.Id = acc.Id;
            accountUpdateList.add(temp);
        }
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
        } 
    }
    
    
}