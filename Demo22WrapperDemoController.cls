public with sharing class Demo22WrapperDemoController {
   
    @AuraEnabled
    public static List<String> getPicklist(){
        List<String> stagePickList= new List<String>();
        Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            stagePickList.add(pickListVal.getLabel());
        }     
       return stagePickList;
    }


    @AuraEnabled
    public static string getAccountDetailsWithRelatedData(String accountId){
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        List<Opportunity> opportunityList = new List<Opportunity>();
        accountList = [SELECT Id,Name,Industry
                       FROM Account
                       WHERE Id = :accountId];
        contactList = [SELECT FirstName,LastName,Phone,Email,AccountId
                       FROM Contact
                       WHERE AccountId =:accountId];   
        opportunityList = [SELECT Id,Name,CloseDate,Amount,AccountId,StageName
                           FROM Opportunity
                           WHERE AccountId=:accountId];


    List<ContactWrapper> tempContactWrapperList = new List<ContactWrapper>();
    List<OpportunityWrapper> tempOpportunityList = new List<OpportunityWrapper>();
    
    for(Contact record : contactList){
        tempContactWrapperList.add(new ContactWrapper(record));
    }

    for(Opportunity record : opportunityList){
        tempOpportunityList.add(new OpportunityWrapper(record) );
        
    }
    

       ResposeJSONWrapper wrapper = new  ResposeJSONWrapper();
       if(accountList.size() > 0){
   
        wrapper.id = accountList.get(0).Id;
        wrapper.name = accountList.get(0).Name;
        wrapper.industry = accountList.get(0).Industry;
        // wrapper.wrapperContactList = contactList;
        wrapper.wrapperContactList = tempContactWrapperList;


       // wrapper.wrapperOpportunityList = opportunityList;
       wrapper.wrapperOpportunityList =tempOpportunityList ;
       
        // wrapper.wrapperStagePickList = stagePickList;

     }
     String response = '';
     response = JSON.serialize(wrapper);
     return response;
  
   }

   


//    save the record in database
    @AuraEnabled
    public static void saveDataToDatabase(String jsonString){
        ResposeJSONWrapper wrapper = new ResposeJSONWrapper();
        wrapper =  (ResposeJSONWrapper)JSON.deserialize(jsonString, ResposeJSONWrapper.class);

        
        List<ContactWrapper> tempcontactList = new List<ContactWrapper>();
        tempcontactList = wrapper.wrapperContactList;
        List<Contact> contactList = new List<Contact>();


        // Here we have to  store the data from contactWraper  as contact
        for(ContactWrapper record : tempcontactList){
            contactList.add(record.contactObj);
        }

        if(contactList.size()>0){
            upsert contactList;
        }


        /*
        List<Opportunity> oppList = new List<Opportunity>();
        oppList = wrapper.wrapperOpportunityList;
        if(oppList.size()>0){
            upsert oppList;
        }
        */
    }


    // save the single Contact in database
    @AuraEnabled
    public static String saveSingleRecord(String jsonString){
        ContactWrapper wrapper = new ContactWrapper();
        wrapper =  (ContactWrapper) JSON.deserialize(jsonString, ContactWrapper.class);
        upsert wrapper.contactObj;
        System.debug('--  Record Id  on new Contact---- '+wrapper.contactObj.Id);
        return wrapper.contactObj.Id;
    }



    // save the Opportunity in Database
    
    @AuraEnabled
    public static void saveOpprtunityToDatabase(String jsonString){
    
            ResposeJSONWrapper wrapper = new ResposeJSONWrapper();
            wrapper =(ResposeJSONWrapper)JSON.deserialize(jsonString, ResposeJSONWrapper.class);
            List<OpportunityWrapper> tempOppList = new List<OpportunityWrapper>();
            tempOppList = wrapper.wrapperOpportunityList;
            List<Opportunity> oppList = new List<Opportunity>();

            for(OpportunityWrapper record : tempOppList){
                oppList.add(record.oppObj);
            }

          
            if(oppList.size()>0){
                upsert oppList;
            }
    
    }


    // Single save  and edit opportunity record  in database
    @AuraEnabled
    public static String  saveSingleOpportunity(String jsonString){
        OpportunityWrapper wrapper = new OpportunityWrapper();
        wrapper =(OpportunityWrapper) JSON.deserialize(jsonString, OpportunityWrapper.class);
        upsert wrapper.oppObj;

        return wrapper.oppObj.Id;
        
    }
    



  
   public class ResposeJSONWrapper{
       public Id id;
       public String name;
       public String industry;
     //  public List<Contact> wrapperContactList;
     public List<ContactWrapper> wrapperContactList;

    
       public List<OpportunityWrapper> wrapperOpportunityList;
    //    public List<String> wrapperStagePickList;


       public ResposeJSONWrapper(){
            //wrapperContactList = new List<Contact>();
            wrapperContactList = new List<ContactWrapper>();

            wrapperOpportunityList = new List<OpportunityWrapper>();
            // wrapperStagePickList = new List<String>();
       }

    }

       public class ContactWrapper{
           public boolean isEditable;
           public Contact contactObj;
           public ContactWrapper(Contact con){
              isEditable = false;
              contactObj = con;
           }
           public ContactWrapper(){
              isEditable = false;
              contactObj = new Contact();
           }
      
       }


       public class OpportunityWrapper{
           public boolean isEditable;
           public Opportunity  oppObj;
           public OpportunityWrapper(Opportunity opp){
               isEditable = false;
               oppObj = opp;
           }

           public OpportunityWrapper(){
            isEditable = false;
            oppObj = new Opportunity();
        }
       }




      
    
}
