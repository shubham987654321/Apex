public class TopperStudent {
    
    
    // find the topper of each college (Student Name,Id and Total Marks) 
    public static void StudentInfo(List<College__c> newList, Map<Id,College__c> oldMap){
        
        Set<Id> collegeIdSet = new Set<Id>();
        for(College__c clg : newList){
            if(clg.Show_Topper__c != oldMap.get(clg.Id).Show_Topper__c){
                if(clg.Show_Topper__c){
                    collegeIdSet.add(clg.Id);
                }
            }
        }
        //  find the total student of particular college and its total Marks
        // using the formulla field of Total Marks in Student Object
        
        
        if(collegeIdSet.size() == 0) return ;
        Map<Id, List<Student__c>> studentList = new Map<Id,List<Student__c>>();
        
        List<College__c> collegeList = new List<College__c>();
        for(College__c clg : [SELECT Id, Name ,
                              (SELECT Id, Name, Total_Marks__c
                               FROM Students__r ORDER BY Total_Marks__c Desc limit 1) 
                               FROM College__c
                               WHERE Id IN : collegeIdSet]){
                                  if(clg.Students__r.size() > 0){
                                      clg.Topper_Student__c = clg.Students__r[0].Name;
                                      collegeList.add(clg);
                                  }
                                  
                              }
        
        if(collegeList.size() > 0){
            update collegeList;
        }
    }
    
    
}