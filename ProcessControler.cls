public class ProcessControler {
        
          @invocableMethod
    public static void postChatterMessage(){
        FeedItem item = new FeedItem();
        item.Body = 'This is a chatter message from Apex method upon - Closed Won Opp';
        item.ParentId ='0F95j000000cDNECA2';
        insert item;
    }
            

}