public class ListDemo {
    public ListDemo(){
        // to initialize the list
        List<String> colorList = new List<String>();
        List<Account> accountList = new List<Account>();
        List<Integer> intgerList = new List<Integer>();
        
        
        // to add values to the list(use add method)
        colorList.add('Black');
        colorList.add('Green');
        colorList.add('Cyan');
        
        // To display the size of list we use size method
        System.debug('The size of list is  '+colorList.size());
        // to get the values at particular index, we use get method
        String color = colorList.get(2);
        System.debug('The Color at index is '+color);
        // to add the value at particular index
        colorList.add(2,'Orange');
        
        // to print the list
        System.debug('The List is '+ colorList);
        // Add one List into another List, we will use addAll method
        List<String> tempList = new List<String>();
          tempList.add('Pink');
        tempList.add('Orange');
        colorList.addAll(tempList);
         System.debug('The List is '+ colorList);
        // to find the first occurence of any element , we use indexOf method
        Integer index = colorList.indexOf('Orange');
        System.debug('The index of  orange is '+index);
        // to remove the element at particular index we will use remove method
        colorList.remove(index);
        System.debug('The list after removing orange is '+colorList);
        // to iterate on list
        for(Integer i=0;i<colorList.size();i++){
            System.debug('Value at Index '+i+' is '+colorList.get(i));
}
        
        // Iteration using foreach method
        Integer count =0;
        for(String colorName : colorList){
            System.debug('The color at index '+count+' '+colorName);
        }
        
        // to remove all elements we use clear method
        colorList.clear();
        System.debug('size after clear method is '+ colorList.size()); // 0

        
    }
}