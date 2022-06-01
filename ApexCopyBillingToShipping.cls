public class ApexCopyBillingToShipping {
    
     public void copyBillingToShipping(Set<Id> accountIdSet){
        List<Account> accountUpdateList = new List<Account>();
        for(Account acc : [SELECT Id,Name,BillingStreet, BillingCity, 
                           BillingState, BillingPostalCode, BillingCountry
                           FROM Account 
                           WHERE Id IN : accountIdSet]){
                               /*
                               acc.ShippingCity = acc.BillingCity;
                               acc.ShippingState = acc.BillingState;
                               acc.ShippingCountry = acc.BillingCountry;
                               acc.ShippingPostalCode = acc.BillingPostalCode;
                               acc.ShippingStreet = acc.BillingStreet;
                               accountUpdateList.add(acc);
                               */
                               
                               Account a = new Account();
                               a.ID = acc.Id;
                               
                              
                               a.ShippingCity = acc.BillingCity;
                               a.ShippingState = acc.BillingState;
                               a.ShippingCountry = acc.BillingCountry;
                               a.ShippingPostalCode = acc.BillingPostalCode;
                               a.ShippingStreet = acc.BillingStreet;
                               accountUpdateList.add(a);

                           }
        if(accountUpdateList.size() > 0){
            update accountUpdateList;
        }
    }


}