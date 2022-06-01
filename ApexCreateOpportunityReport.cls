public class ApexCreateOpportunityReport {
    
    public  Map<String,Decimal> monthtypeToAmountMap;
    public Map<String,Integer> monthtypeToCountMap;
    
    public  ApexCreateOpportunityReport(){
        List <String> monthList = new List<String>{'','Jan','Feb','Mar','Apr',
            'May','Jun','Jul','Aug','Sep','Oct',
            'Nov','Dec'};
              monthtypeToAmountMap = new Map<String,Decimal>();
              monthtypeToCountMap  = new  Map<String,Integer>();
        for(Opportunity opp : [Select Id, Amount, StageName , Type, CloseDate, OwnerId
                               From Opportunity
                               Where Type != NULL and
                               StageName ='Closed Won' 
                               and Amount>0]){
                                   Integer month = opp.CloseDate.month();
                                   // System.debug('Month is '+month);
                                   Integer year  = opp.CloseDate.year();
                                   
                                   String key = monthList.get(month)+'-'+year+'-'+opp.Type+'-'+opp.OwnerId;
                                   if(!monthtypeToAmountMap.containsKey(key)) {
                                       monthtypeToAmountMap.put(key,0);
                                       monthtypeToCountMap.put(key,0);
                                   }
                                   Decimal  tempAmount = monthtypeToAmountMap.get(key);
                                   tempAmount = tempAmount+opp.Amount;
                                   monthtypeToAmountMap.put(key,tempAmount);
                                   Integer tempCount =monthtypeToCountMap.get(key);
                                   tempCount =tempCount+1;
                                   monthtypeToCountMap.put(key,tempCount);
                                   
                               }
        
        // month + year + type + user : paisa
        for(String key : monthtypeToAmountMap.keySet()){
            System.debug(key+'   '+monthtypeToAmountMap.get(key)+ '  '+monthtypeToCountMap.get(key));
        }
        
        
        
        
    }
    
}