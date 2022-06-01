@isTest
public class StudentTriggerHandlerTest1 {
    
    @testSetup
    static void setup(){
        
        List <College__c> collegeList = new List<College__c>();
        List <Student__c> studentList = new List<Student__c>();
        collegeList =TestDataFactory.createCollegeList(5,'testCollege',false);
        
        for(College__c clg : collegeList){
            clg.isActive__c = true;
        }
        
        insert collegeList;
        
        for(College__c clg : collegeList){
            studentList.addAll(TestDataFactory.createStudentList(10,'testStudent',clg, false));  
        }
        
        insert studentList;
        
    }
    
    @isTest
    static void testCountOnCreate(){
        List<College__c> collegeList = new List<College__c>();
        collegeList = [SELECT Id FROM College__c WHERE NAME LIKE 'testcollge%'];
        for(College__c clg  : collegeList){
            System.assertEquals(10, clg.Student_Count__c);
        }
        
    }
    
    /*
     @isTest
    static void testCountOnUpdate(){
        List<Student__c> studentList = new List<Student__c>();
        for(Student__c stud : studentList){
            if(stud.College__c != collegeList.get(0).Id){
                stud.College__c  = collegeList.get(0).Id;
            }
        }
        update studentList;   
        
        
        for(College__c clg  : [SELECT Id, Student_Count__c
                               FROM College__c
                               WHERE Id =: collegeList.get(0).Id]){
                                   System.assertEquals(50,clg.Student_Count__c );
                               }
        
    }
   */

    
}