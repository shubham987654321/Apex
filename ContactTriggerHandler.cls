public class ContactTriggerHandler {
    public static void preventDuplicate(List<Contact> newList, Map<Id, Contact>oldMap){
        // Get all contacts getting inserted
        // Check if same contact exist in database
        // if yes , Throw an error
        // If no , Allowe insert of the record.
        // duplicate contact is based on 4 fields , First name , last name , email , birthdate
        Set<String> firstNameSet = new Set<String>();
        Set<String> lastNameSet = new Set<String>();
        Set<String> emailSet = new Set<String>();
        Set<Date> birthDateSet = new Set<Date>();
        // 1000 , 2000 records , Salesforce process them in a batch of 200 records only
        for(Contact con : newList){
            if(oldMap == NULL || con.FirstName != oldMap.get(con.Id).FirstName 
               || con.LastName != oldMap.get(con.Id).LastName 
               || con.Email != oldMap.get(con.Id).Email 
               || con.Birthdate != oldMap.get(con.Id).Birthdate){
                   firstNameSet.add(con.FirstName);
                   lastNameSet.add(con.LastName);
                   emailSet.add(con.Email);
                   birthDateSet.add(con.Birthdate);
               }
        }
        Set<String> uniqueContactSet = new Set<String>();
        for(Contact con : [SELECT Id,FirstName,LastName,Email,Birthdate
                           FROM Contact
                           WHERE FirstName IN :firstNameSet
                           AND LastName IN :lastNameSet
                           AND Email IN :emailSet
                           AND Birthdate IN :birthDateSet]){
                               uniqueContactSet.add((con.FirstName+'*'+con.LastName+'*'+con.Email+'*'+String.valueOf(con.Birthdate)).toUpperCase());
                           }
        for(Contact con : newList){
            String key=con.FirstName+'*'+con.LastName+'*'+con.Email+'*'+String.valueOf(con.Birthdate);
            if(uniqueContactSet.contains(key.toUpperCase())){
                // con.addError('This is a duplicate Contact');
                con.addError(System.Label.DuplicateContactError);
            }else{
                uniqueContactSet.add(key.toUpperCase());
            }
        }
    }
    
}