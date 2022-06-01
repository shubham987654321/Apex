@isTest
public class StudentTriggerHandlerTest {
    
    public static List<College__c> collegeList;
    public static List<Student__c> studentList;
    public Static User usr;    
    
    public static User createDemoUser(){
         Profile p = [SELECT Id FROM Profile WHERE Name='Demo Profile']; 
        usr = new User(Alias = 'standt', Email='kumarshubham221199@gmail.com', 
                       EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                       LocaleSidKey='en_US', ProfileId = p.Id, 
                       TimeZoneSidKey='America/Los_Angeles', UserName='shubhamtxtestst@testorg.com');
        insert usr;
        return usr;
    }
   
      public static void createData(){   
        collegeList  = new List<College__c>();
        studentList = new List<Student__c>();
        collegeList = TestDataFactory.createCollegeList(5,'testCollege',false);
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
    static void testCountonCreate(){
       usr = createDemoUser();
        System.runAs(usr){
            createData();
            for(College__c clg  : [SELECT Id, Student_Count__c
                                   FROM College__c
                                   WHERE Id IN:collegeList]){
                                       System.assertEquals(10,clg.Student_Count__c );
                                   }
            
        }
    }
    
    @isTest
    static void testCountonUpdate(){
        usr = createDemoUser();
        System.runAs(usr){
            createData();
            for(Student__c stud : studentList){
                if(stud.College__c != collegeList.get(0).Id){
                    stud.College__c  = collegeList.get(0).Id;
                }
            }
            Test.startTest();  // It Reset all our Governor limit
            update studentList;  
            Test.stopTest();    // It reset all our Governor limit
            
            
            for(College__c clg  : [SELECT Id, Student_Count__c
                                   FROM College__c
                                   WHERE Id =: collegeList.get(0).Id]){
                                       System.assertEquals(50,clg.Student_Count__c );
                                   }
            
        }
        
    }
    
    
    
    
     @isTest
    static void testCountonDelete(){
        usr = createDemoUser();
        System.runAs(usr){
             createData();
        delete studentList;
        
        for(College__c clg  : [SELECT Id, Student_Count__c
                               FROM College__c
                               WHERE Id  =: collegeList.get(0).Id]){
                                   System.assertEquals(0,clg.Student_Count__c );
                               }
        }
       
    }
    
    
    @isTest
    static void testCountUndelete(){
        usr = createDemoUser();
        
        System.runAs(usr){
            createData();
            delete studentList;
            List<Student__c> undeleteList = new List<Student__c>();
            
            
            undeleteList = [SELECT Id,Name 
                            FROM Student__c
                            WHERE isDeleted = true
                            AND Id IN : studentList
                            ALL ROWS];
            
            undelete undeleteList;
            
            for(College__c clg : [SELECT Id,Student_Count__c
                                  FROM College__c
                                  WHERE Id =:collegeList.get(0).Id]){
                                      System.assertEquals(10,clg.Student_Count__c);
                                  }
            
        }
        
    }
    
    
    
    
    
    
    /*
   
    @isTest
    static void testCountOnCreate(){
        List<College__c > collegeList = new List<College__c>();
        for(Integer i=1;i<=5;i++){
            College__c  clg = new College__c();
            clg.Name= 'Test College '+i;
            
            clg.Email__c = 'TestCollege'+i+'@mtxb2b.com';
            clg.isActive__c = true;
            clg.State__c = 'Bihar';
            collegeList.add(clg);
        }
        
        insert collegeList;
        
        List<Student__c> studentList = new List<Student__c>();
        
        for(Integer i=1;i<=50;i++){
            Student__c st = new Student__c();
            st.Name = 'testStudent'+i;
            st.Adhar_Number__c = i<10 ? '1111-2222-440'+i : '1111-2222-550'+i;
            st.Age__c =22;
            st.State__c = 'Bihar';
            st.College__c = collegeList.get(math.mod(i, 5)).Id;
            studentList.add(st);
        }
        
        insert studentList;
        
        
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id IN: collegeList]){
                                  System.assertEquals(10, clg.Student_Count__c);
                              }
        
        for(Student__c stud : studentList){
            if(stud.College__c != collegeList.get(0).Id){
                stud.College__c = collegeList.get(0).Id;
            }
        }
        update studentList;
        for(College__c clg : [SELECT Id,Student_Count__c 
                              FROM College__c
                              WHERE Id = :collegeList.get(0).Id]){
                                  System.assertEquals(50, clg.Student_Count__c);
                              }
        
    }
    */
    
    
}