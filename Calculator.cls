public class Calculator {
    Public Integer num1;
    Public Integer num2;
    Public Integer result;
    
    public Calculator(Integer n1, Integer n2){
        num1 = n1;
        num2 = n2;
    }
    
    public void sum(){
        result=num1+num2;
        System.debug('Sum is' + result);
    }
    
     public void mulitply(){
        result=num1*num2;
        System.debug('Sum is' + result);
    }

}