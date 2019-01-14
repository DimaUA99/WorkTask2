@isTest
private class TestRestrictContactByName2 {

    @isTest static void testByName(){
         Contact c = new Contact(LastName = 'INVALIDNAME', FirstName = 'Error');


        System.Test.startTest();
        try{
            insert c;
        }catch(Exception e){
           
        }
        System.Test.stopTest();
    }
}