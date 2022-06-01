public class AccountTriggerHandler {
    
    public static void copyBillingToShipping(List<Account> newList, Map<Id, Account> oldMap){
        
        for(Account acc : newList){
            Boolean isBillingChanged = false;
            Boolean isShippingChanged = false;
            
            if(oldMap != NULL){
                isBillingChanged = (
                                     acc.BillingCity  !=  oldMap.get(acc.Id).BillingCity
                                    ||  acc.BillingState  !=  oldMap.get(acc.Id).BillingState
                                    ||   acc.BillingCountry !=  oldMap.get(acc.Id).BillingCountry
                                    ||  acc.BillingStreet !=  oldMap.get(acc.Id).BillingStreet);
                
                
                isShippingChanged =  (
                                      acc.ShippingCity !=  oldMap.get(acc.Id).ShippingCity
                                     ||  acc.ShippingState  !=  oldMap.get(acc.Id).ShippingState
                                     ||   acc.ShippingCountry  !=  oldMap.get(acc.Id).ShippingCountry
                                     ||  acc.ShippingStreet !=  oldMap.get(acc.Id).ShippingStreet);
            }
            
            
            
            if(oldMap == NULL || acc.Copy_Billing_to_Checking__c != oldMap.get(acc.Id).Copy_Billing_to_Checking__c
               || isBillingChanged
               || isShippingChanged)
                {
                    
                    if(acc.Copy_Billing_to_Checking__c){
                        if(isShippingChanged){
                            acc.addError('You are not allowed to Update the shipping address');
                        }else{
                            acc.ShippingCity = acc.BillingCity;
                            acc.ShippingState = acc.BillingState;
                            acc.ShippingCountry = acc.BillingCountry;
                            acc.ShippingPostalCode = acc.BillingPostalCode;
                            acc.ShippingStreet = acc.BillingStreet;
                        }
                    } 
                }
        }
        
        
    }
    
    
    
    public static void CreateField(){
        Account acc = new Account();
        
    }
    
}