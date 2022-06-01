public class UserTriggerHandler {
    public static void updateAccountFavColor(List<User> newList,Map<Id,User> oldMap){
        Set<Id> ownerIdSet = new Set<Id>();
        Map<Id,String> userIdToColorMap = new Map<Id,String>();
        for(User usr : newList){
            if(usr.Favourite_Color__c != oldMap.get(usr.Id).Favourite_Color__c){
                ownerIdSet.add(usr.Id);
                userIdToColorMap.put(usr.Id,usr.Favourite_Color__c);
            }
        }
        
        // find out all accounts associated to the Users
        if(ownerIdSet.size () > 0){
            List<Account> accountUpdateList = new List<Account>();
            for(Account acc : [SELECT Id,Favourite_Color__c,OwnerId 
                               FROM Account 
                               WHERE OwnerId IN :ownerIdSet]){
                                   acc.Favourite_Color__c = userIdToColorMap.get(acc.OwnerId);
                                   accountUpdateList.add(acc);                 
                               }
            
            if(accountUpdateList.size() > 0){
                update accountUpdateList;
            }
        }
    }
    
}