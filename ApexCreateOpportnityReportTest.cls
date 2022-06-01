@isTest
public class ApexCreateOpportnityReportTest {
    
    static testmethod void testOportunityReport(){
        Id prepaidRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Prepaid').getRecordTypeId();
        List<Opportunity> oppList = new List<Opportunity>();
        for(Integer i=1; i <=30 ; i++){
            Opportunity opp =new Opportunity();
            opp.StageName = 'Closed Won';
            opp.Name = 'Test Default Opportunity '+i;
            if(i <= 15){
                opp.Type = 'New Customer';
                opp.CloseDate = Date.today(); // 15000
            }else{
                opp.Type = 'Existing Customer - Upgrade';
                opp.CloseDate = Date.today().addDays(30);
            }
            opp.RecordTypeId = prepaidRecordTypeId;
            opp.Amount = 1000;
            oppList.add(opp);
        } 
        if(oppList.size() > 0){
            insert oppList;
        } 
        
        ApexCreateOpportunityReport  obj = new  ApexCreateOpportunityReport();
        system.debug('>>>>$$$$'+ obj.monthtypeToAmountMap);
        system.debug('>>>>$$$$'+ obj.monthtypeToCountMap);
        
        
        String key = 'Mar-2022-New Customer-' + UserInfo.getUserId();
        System.assert(obj.monthtypeToAmountMap.containsKey(key));
        System.assertEquals(150, obj.monthtypeToAmountMap.get(key));
        System.assertEquals(15, obj.monthtypeToCountMap.get(key));
        key = 'Apr-2022-Existing Customer - Upgrade-'+UserInfo.getUserId(); 
        System.assert(obj.monthtypeToCountMap.containsKey(key));
        System.assertEquals(15000, obj.monthtypeToAmountMap.get(key));
        System.assertEquals(15, obj.monthtypeToCountMap.get(key));
       
    }
    
    
}