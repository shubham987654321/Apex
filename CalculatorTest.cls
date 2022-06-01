@isTest
public class CalculatorTest {
   
    // test methods
     @isTest
    static void testSum(){
       Calculator calc = new Calculator(5,-1);
        calc.sum();
        System.assertEquals(4,calc.result,'Expected and actual do not match');  
    }
    
    
    
    static testmethod void testmultiply(){
       Calculator calc = new Calculator(5,-1);
        calc.mulitply();
    }

        

}