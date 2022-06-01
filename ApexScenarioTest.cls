@isTest
public class ApexScenarioTest {
static testmethod void testSolutionUsingMaps(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        Contact con = new Contact();
        con.FirstName = 'Contact';
        con.LastName = 'Demo10';
        con.Title = 'test';
        con.AccountId = acc.Id;
        insert con;
        ApexScenario1 obj = new ApexScenario1();
        obj.solutionUsingMaps();
        List<Account> accList = [SELECT Id,Active__c 
                                 FROM Account
                                 WHERE Id =:acc.Id];
        System.assertEquals('Yes',accList.get(0).Active__c);
        
    }
    
    static testmethod void testSolutionUsingSet(){
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;
        Contact con = new Contact();
        con.FirstName = 'Contact';
        con.LastName = 'Demo10';
        con.Title = 'test';
        con.AccountId = acc.Id;
        insert con;
        ApexScenario1 obj = new ApexScenario1();
        obj.solutionUsingSet();
        List<Account> accList = [SELECT Id,Active__c 
                                 FROM Account
                                 WHERE Id =:acc.Id];
        System.assertEquals('Yes',accList.get(0).Active__c);
        
    }

}