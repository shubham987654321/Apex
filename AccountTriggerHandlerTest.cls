@isTest
public class AccountTriggerHandlerTest {
    
    static testmethod void testCopyBillingToShippingOnUpdate(){
        Account acc = new Account();
        acc.Name = 'test';
        acc.Copy_Billing_to_Checking__c = true;
        acc.BillingCity = 'Patna';
        acc.BillingCountry = 'India';
        acc.BillingPostalCode = '305001';
        acc.BillingStreet = 'Rajendaranagr';
        acc.BillingState = 'Bihar';
        
        insert acc;
        acc.BillingCity = 'Begusarai';
        update acc;
        
        List <Account> accountList = [SELECT Id,ShippingCity,ShippingState,ShippingPostalCode,ShippingCountry,
                                      ShippingStreet 
                                      FROM Account
                                      WHERE Id =:acc.Id];
        
      
       
       
        System.assertEquals(acc.BillingCity, accountList.get(0).ShippingCity);
        System.assertEquals(acc.BillingState, accountList.get(0).ShippingState);
        System.assertEquals(acc.BillingPostalCode, accountList.get(0).ShippingPostalCode);
        System.assertEquals(acc.BillingStreet, accountList.get(0).ShippingStreet);
         System.assertEquals(acc.BillingCountry, accountList.get(0).ShippingCountry);
        
    }
    
    
}