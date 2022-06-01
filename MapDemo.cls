public class MapDemo {
    public MapDemo(){
        // to initialize a map
        Map<String, String>  monthToColorMap= new Map<String,String>();
        
        // to add value to the map we use put method
        monthToColorMap.put('jan', 'Blue');
        monthToColorMap.put('Feb', 'Red');
        monthToColorMap.put('March', 'Black');
        
        // to Print the size of Map we use size ()
        System.debug('The size of Map is '+monthToColorMap.size());
        System.debug('Map is '+monthToColorMap);
        
        // if we add a value a map with existing key, it overrides the value
        monthToColorMap.put('March','Yellow');
        
        // Keys are case sensitive like values in set
        monthToColorMap.put('MARCH','Black');
        System.debug('After updating March month Map is '+monthToColorMap);
        // to get the value at a particulat key we use get(key) method
        String color = monthToColorMap.get('Feb');
        System.debug('Color for feb month is  '+color);
        // to check if a map contains a key or not we use containsKey method
        System.debug('do Map contains Key : Feb  '+monthToColorMap.containsKey('Feb')); // true
        System.debug('do Map contains Key : April  '+monthToColorMap.containsKey('April')); // false
        
        // We can extrack all the keys from the Map in a set using method keySet
        Set<String> mapKeySet = monthToColorMap.keySet();
        System.debug('the Keys are  '+mapKeySet); 
        
        // we can extrack all the values in form of List
        List<String> mapValuesList = new List<String>();
        mapValuesList = monthToColorMap.values();
        System.debug('the values are  '+mapValuesList); 
        
        
        // to iterate over the map, we itrate keys and get the value from the key
        for(string Key : mapkeySet){
            System.debug('For the Key '+Key + ' Value is '+monthToColorMap.get(Key));
        }
        
        
        
        
        
        // to clear all the values from map
        monthToColorMap.clear();
        System.debug(' The size of Map is '+monthToColorMap.size());
        
        
    }
    
}