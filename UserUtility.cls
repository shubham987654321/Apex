public class UserUtility {
    
    @future
    public static  void createChatterUser(String lastName, String alias,
                                  String email, String username){
                                      
                                      Profile  profRecord = [SELECT Id
                                                             FROM Profile
                                                             WHERE NAME ='Chatter Free User'];
                                      User userRecord = new User();
                                      userRecord.ProfileId = profRecord.Id;
                                      userRecord.Alias = alias;
                                      userRecord.Email = email;
                                      userRecord.LastName = lastName;
                                      userRecord.userName = userName;
                                      userRecord.EmailEncodingKey = 'UTF-8';
                                      userRecord.LanguageLocaleKey = 'en_US';
                                      userRecord.LocaleSidKey = 'en_US';
                                      userRecord.TimeZoneSidKey = 'America/Los_Angeles';
                                      
                                      
                                      
                                      try{
                                          insert userRecord;
                                      }catch(DmlException ex){
                                          Error_log__c  log = new Error_log__c();
                                          log.Trace__c = ex.getMessage();
                                          insert log; 
                                      }
                                      
                                      
                                  }
    
}