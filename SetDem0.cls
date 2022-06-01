public class SetDem0 {
    public SetDem0(){
        // to initialize a set
        Set<String> colorSet = new Set<String>();
        // to Add values to set , we use Add method
        colorSet.add('Black');
        colorSet.add('Green');
        colorSet.add('Yellow');
        // to print the size of the Set we use size method
        System.debug('Set size is '+colorSet.size()); // 3
        // if we try to add duplicate values to the set , they do not get added and it do not throw any error as well
        colorSet.add('Green');
        colorSet.add('Red');
        System.debug('Set size is '+colorSet.size()); // 4 , because Green will not get added.
        // Apex is case insensitive , but the values in the Set are case sensitive
        colorSet.add('GREEN');
        System.debug('Set size is '+colorSet.size()); // 5
        System.debug('Set values are '+colorSet);
        
        
        // to Add one Set to another , List to Set as well ,  we have addAll Method
        List<String> tempList = new  List<String>();
        tempList.add('Orange');
        Set<String> tempSet = new Set<String>();
        tempSet.add('Pink');
        tempSet.add('Orange');
        colorSet.addAll(tempList);
        colorSet.addAll(tempSet);
        System.debug('Set size is '+CoLoRsEt.size());
        System.debug('Set values are '+colorSet);
        
        // To iterate the set
        for(String color : colorSet){
            SYstem.debug('>>>>'+color);
        }
        // to clear the Set 
        colorSet.clear();
        System.debug('Set size is '+CoLoRsEt.size());
        System.debug('Set values are '+colorSet);

        

    }
}