public class TopperCollegeContoller {

    @AuraEnabled
    public static List<College__c> getCollege(){
            return [SELECT Id, Name FROM College__c];
    }
   

    @AuraEnabled
    public static string getTopper(String collegeId){
        System.debug('>>>>>>>>>'+collegeId);
        Id clgId = (Id) collegeId;
        // Using the Marks
        //Set of College
        Set<Id> collegeIdSet = new Set<Id>();

        // Set of Student and its marks
        Map<Id,Double> studentTotalMarks = new Map<Id,Double>();
        Map<Id,String> studentIdToName = new Map<Id,String>();

        for(Student__c student : [SELECT Id, Name
                                 FROM Student__c
                                 WHERE College__c =: clgId]){
                                    studentTotalMarks.put(student.Id,0);
                                    studentIdToName.put(student.Id,student.Name);
                                 }
        
        for(Marks__c mark :[SELECT Score__c, Id, Student__c,
                           Student__r.College__c,Student__r.Name
                            FROM Marks__c
                            WHERE Student__r.College__c =: clgId]){
                                
                                Double tempMarks = studentTotalMarks.get(mark.Student__c) + mark.Score__c;
                                studentTotalMarks.put(mark.Student__c,tempMarks);
                            }
        // compare with Student and give the result
       String studentName='';
       Decimal sMark=0;
       

       System.debug('>>>>>>>>>'+studentTotalMarks);
       System.debug('before calculation ' + studentName);
        
        for(Id studentId : studentTotalMarks.keySet()){
            if(sMark<studentTotalMarks.get(studentId)){
                sMark=studentTotalMarks.get(studentId);
                 studentName=studentIdToName.get(studentId);
            } 
        }

        System.debug('after calculation ' + studentName);
        try {
         return studentName+'*' + sMark;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
