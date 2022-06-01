public class TopperOfCollege { 
    // find the topper of each college
   
    public void topper(){
        // Total  student of each college
        Map<Id, List<Student__c>> StudentInCollege  = new Map<Id, List<Student__c>>();
         
        // Map of Student Id and and it's total marks
        Map<Id,Decimal> StudentMarks  = new   Map<Id,Decimal>();
      
        for(Student__c st: [Select College__c,id, Name , Total_Marks__c
                                   from Student__c]){
                                       if(!StudentInCollege.containsKey(st.College__c)){
                                           StudentInCollege.put(st.College__c,new List<Student__c>());
                                       }
                                       StudentInCollege.get(st.College__c).add(st);
                                       StudentMarks.put(st.Id,st.Total_Marks__c);
                                       
                                  }
        
        
        
        // iterate over the Map of Collegid and all the student inside the college
        System.debug('----------------- Total Student on Each College  ----------------');
        for(Id collegeid : StudentInCollege.keySet()){
            List<Student__c> tempStudentList = StudentInCollege.get(collegeid);
            String allStudentId = ' ';
             
            if(tempStudentList.size()>0){
                for(Student__c st1 : tempStudentList){
                    allStudentId +=st1.id+',';
                }
            }
        
           System.debug('College Id: '+collegeid+' studentName: '+allStudentId);
        }
        
        
        // Iterate on the Map(StudentMarks) of  student and its total Marks 
          System.debug('----------------- Student having Marks  ----------------');
        for(Id studentid : StudentMarks.keySet()){
            System.debug('StudentId: '+ studentid +' Total Marks: '+StudentMarks.get(studentid));
        }
        
        
        
        
        
        
        
        // topperStudent of each college
        System.debug('&&&&&&&&&&&&&&&&&&&& Topper of Each college &&&&&&&&&&&&&&&&&&&&&&&&&');
         
         for(Id collegeid : StudentInCollege.keySet()){
              
             // List of all the student of a particular collegeid
             List<Student__c> tempStudentList = StudentInCollege.get(collegeid); 
             
             Decimal tempTotalMarks=0;
             String topperStudentId='';
             if(tempStudentList.size()>0){
                 for(Student__c tempStudent : tempStudentList){
                     
                     // if current total Marks is greater than previous Marks than replace it.
                     if(temptotalMarks<=StudentMarks.get(tempStudent.Id)){
                         tempTotalMarks = StudentMarks.get(tempStudent.Id);
                         topperStudentId = tempStudent.Id;
                         
                     }
                     
                 }
                 System.debug('CollgeId: '+collegeid + ' TopperStudentId: '+ topperStudentId +' TotalMarks: '+tempTotalMarks);
                 
             }                 
           
        }   
    }
    
    
    
    // Another method
      public void  FindTopper(Set<Id> collegeIdSet){
        Map<Id,Set<Id>> collegeIdToStudentIdMap = new Map<Id,Set<Id>>();
        Map<Id,Decimal> studentIdToTotalMap = new Map<Id,Decimal>();
        Map<Id,String> collegeIdToName = new Map<Id,String>();
        Map<Id,String> studentIdToName = new Map<Id,String>();
        for(Marks__c marks : [SELECT Id,Score__c,Student__c,Student__r.Name,
                              Student__r.College__c,Student__r.College__r.Name
                              FROM Marks__c
                              WHERE Student__r.College__c IN :collegeIdSet]){
                                  collegeIdToName.put(marks.Student__r.College__c,marks.Student__r.College__r.Name);
                                  studentIdToName.put(marks.Student__c,marks.Student__r.Name);
                                  if(!collegeIdToStudentIdMap.containsKey(marks.Student__r.College__c)){
                                      collegeIdToStudentIdMap.put(marks.Student__r.College__c,new Set<Id>());
                                  }
                                  	collegeIdToStudentIdMap.get(marks.Student__r.College__c).add(marks.Student__c);
                                  // calculating studentIdToTotalMap data
                                  if(!studentIdToTotalMap.containsKey(marks.Student__c)){
                                      studentIdToTotalMap.put(marks.Student__c,0);
                                  }
                                  	Decimal score = studentIdToTotalMap.get(marks.Student__c);
                                  	score = score + marks.Score__c;
                                  	studentIdToTotalMap.put(marks.Student__c,score);
                              }
        for(Id collegeID : collegeIdToStudentIdMap.keySet()){
            Set<Id> studentsIdSet = collegeIdToStudentIdMap.get(collegeID);
            Decimal maxMarks = 0;
           	Id topperId = null;
            for(Id studentId :  studentsIdSet){
                if(studentIdToTotalMap.get(studentId) > maxMarks){
                    maxMarks = studentIdToTotalMap.get(studentId);
                    topperId = studentId;
                }
            }
            System.debug('College : '+collegeIdToName.get(collegeID)+' Topper is : '+studentIdToName.get(topperId)+' Max MArks : '+maxMarks);
        }
    }

    
    
    
    
    // third Method O(n)  time Complexity 
    public void getTopper(Set<Id> collegeIdSet){
          Map<Id,String> collegeIdToName = new Map<Id,String>();
            Map<Id,String> studentIdToName = new Map<Id,String>();

          Map<String,Decimal> collegeIdToMarksMap = new Map<String,Decimal>();
          for(Marks__c marks : [SELECT Id,Score__c,Student__c,Student__r.Name,
                                Student__r.College__c,Student__r.College__r.Name
                                FROM Marks__c
                                WHERE Student__r.College__c IN :collegeIdSet]){
                                  if(!collegeIdToMarksMap.containsKey(marks.Student__r.College__c+'*'+marks.Student__c)){
                                      collegeIdToMarksMap.put(marks.Student__r.College__c+'*'+marks.Student__c,0);
                                  }
                                  	Decimal score = collegeIdToMarksMap.get(marks.Student__r.College__c+'*'+marks.Student__c);
                                  	score = score + marks.Score__c;
                                  	collegeIdToMarksMap.put(marks.Student__r.College__c+'*'+marks.Student__c,score);
                                }
        for(String key : collegeIdToMarksMap.keySet()){
            Id collegeId = key.split('\\*').get(0);
            Id studentId = key.split('\\*').get(1);
            Decimal totalMarks = collegeIdToMarksMap.get(key);
            System.debug('>>>'+collegeId+'>>>>'+studentId+'>>>>'+totalMarks);
            
        }
        
        
        Map<Id,String> collegeIdToTopperMap = new Map<Id,String>();
        for(String key : collegeIdToMarksMap.keySet()){
            Id collegeId = key.split('\\*').get(0);
            Id studentId = key.split('\\*').get(1);
            Decimal totalMarks = collegeIdToMarksMap.get(key);
          //  System.debug('>>>'+collegeId+'>>>>'+studentId+'>>>>'+totalMarks);
            if(!collegeIdToTopperMap.containsKey(collegeId)){
                collegeIdToTopperMap.put(collegeId,studentId+'*'+0);
            }
            Decimal tempMarks = Decimal.valueOf(collegeIdToTopperMap.get(collegeId).split('\\*').get(1));
            if(totalMarks > tempMarks){
                collegeIdToTopperMap.put(collegeId,studentId+'*'+totalMarks);
            }            
        }
        for(Id collegeId : collegeIdToTopperMap.keySet()){
            Id studentId = collegeIdToTopperMap.get(collegeId).split('\\*').get(0);
            System.debug('College : '+collegeIdToName.get(collegeId)+
                         ' Topper is : '+studentIdToName.get(studentId)+
                         ' Max MArks : '+collegeIdToTopperMap.get(collegeId).split('\\*').get(1));
        }    
  
    }


    
    
    
    /*
     
        Map<Id,Integer> collegeIdToMaxMarks = new Map<Id,Integer>();
        Map<Id,String> collegeToTopperStudentNameMap = new Map<Id,String>();
          
        
        
        
            
        for(Student__c student : [SELECT Id,Name,Total_Marks__c,College__c
                                  FROM Student__c
                                  WHERE College__c IN:collegeIdSet]){
                                      if(!collegeIdToMaxMarks.containsKey(student.College__c)){
                                          collegeIdToMaxMarks.put(student.College__c,0);
                                          collegeToTopperStudentNameMap.put(student.College__c, '');
                                      }
                                      Integer currentMaxMarks = collegeIdToMaxMarks.get(student.College__c);
                                      String topper_name = collegeToTopperStudentNameMap.get(student.College__c);
                                      
                                      if(student.Total_Marks__c > currentMaxMarks){
                                          currentMaxMarks = (Integer)student.Total_Marks__c;
                                          topper_name = student.Name;
                                          collegeIdToMaxMarks.put(student.College__c,currentMaxMarks);
                                          collegeToTopperStudentNameMap.put(student.College__c, topper_name);
                                      }
                                  }
        Map<Id,String> collegeIdToCollegeNameMap = new Map<Id,String>();
        for(College__c clg : [SELECT Id,Name 
                              FROM College__c]){
                                  collegeIdToCollegeNameMap.put(clg.Id,clg.Name);
                              }
        
        for(Id collegeId : collegeIdToMaxMarks.keySet()){
            if(collegeIdToMaxMarks.get(collegeId) > 0){
                 System.debug('Maximum marks of ' + collegeIdToCollegeNameMap.get(collegeId) + 
                         ' college is ' + collegeIdToMaxMarks.get(collegeId) + ' and topper student name is ' + collegeToTopperStudentNameMap.get(collegeId));
            }else{
                System.debug('Maximum marks of the collge is  0');
            }
        }
    }

     */
    
    
    
    
    
    
}