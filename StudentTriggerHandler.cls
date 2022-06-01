public class StudentTriggerHandler {
    /*
    public static void updateCount(List<Student__c> newList, Map<Id,Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        
        if(newList != NULL){
            for(Student__c student : newList){
                if(oldMap == NULL || student.College__c != oldMap.get(student.Id).College__c){
                    if(student.College__c != NULL){
                        collegeIdSet.add(student.College__c);
                    }
                    if(oldMap!= NULL && oldMap.get(student.Id).College__c != NULL){
                        collegeIdSet.add(oldMap.get(student.Id).College__c);
                    }
                }
            }
        }
        else{
            for(Id studentId : oldMap.keySet()){
                if(oldMap.get(studentId).College__c != NULL){
                    System.debug('>>>>>> '+oldMap.get(studentId).College__c);
                    collegeIdSet.add(oldMap.get(studentId).college__c);
                }
            }
        }
        
        if(collegeIdSet.size() == 0) return;
        Map<Id,Integer> collegeIdToCountMap = new Map<Id,Integer>();
        for(College__c college : [SELECT Id, 
                                  (SELECT Id FROM Students__r)
                                  FROM College__c
                                  WHERE Id IN :collegeIdSet]){
                                      collegeIdToCountMap.put(college.Id,college.Students__r.size());
                                  }
        List<College__c> collegeList = new List<College__c>();
        for(Id collegeId : collegeIdToCountMap.keySet()){
            College__c college = new College__c();
            college.Id = collegeId;
            college.Student_Count__c = collegeIdToCountMap.get(collegeId);
            collegeList.add(college);
        }
        if(collegeList.size() > 0){
            update collegeList;
        }
        
        
    }
    */
   
    
    public static void updateCountQueryOnStudentUsingAggrigateQuery(List<Student__c> newList, Map<Id,Student__c> oldMap){
        Set<Id> collegeIdSet = new Set<Id>();
        if(newList != NULL){
            for(Student__c student : newList){
                if(oldMap == NULL || student.college__c != oldMap.get(student.Id).college__c){
                    if(student.College__c != NULL){
                        collegeIdSet.add(student.College__c);
                    }
                    if(oldMap != NULL &&  oldMap.get(student.Id).college__c != NULL){
                        collegeIdSet.add(oldMap.get(student.Id).college__c);
                    }
                }
            }  
        }else{
            for(Student__c student : oldMap.values()){
                if(student.College__c != NULL){
                    collegeIdSet.add(student.College__c);
                }
            }
        }
        
        List<College__c> collegeUpdateList = new List<College__c>();
        Map<Id,Integer> collegeIdToStudentCountMap = new Map<Id,Integer>();
        for(Id collegeId : collegeIdSet){
            collegeIdToStudentCountMap.put(collegeId,0);
        }
        
        for(AggregateResult ar : [SELECT College__c, COUNT(ID) cnt,AVG(Age__c)
                                  FROM Student__c
                                  WHERE College__c IN : collegeIdSet
                                  GROUP BY College__c]){
                                      collegeIdToStudentCountMap.put((Id)ar.get('College__c'), (Integer)ar.get('cnt'));
                                  }
        
        
        for(Id collegeId : collegeIdToStudentCountMap.keySet()){
            College__c college = new College__c();
            college.Id = collegeId;
            college.Student_Count__c = collegeIdToStudentCountMap.get(collegeId);
            
            collegeUpdateList.add(college);
        }         
        if(collegeUpdateList.size() > 0){
            update collegeUpdateList;
        }
    }


    
}