public class UserUtitlityDemo {

    public static void callFutureMethod(){
        Account acc = new Account();
        acc.Name = 'Future Pvt Ltd';
        acc.Type = 'Prospect';
        
        try{
            insert acc;   // Don't forget
        }catch(DmlException ex){
            Error_Log__c  log = new Error_Log__c();
            log.Trace__c = ex.getMessage();
            insert log;
        }//end of catch
        // end of call of future method--> gets executed in a seprate thread
        UserUtility.createChatterUser ('HN','hn123','kumarshubham221199@gmail.com','shubhamErrorLog@gmail.com');
        // call future method
    } 
    
}