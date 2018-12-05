@isTest
private class TestRestrictContactByName {

    @isTest static void testByName(){
   		 Contact c = new Contact(LastName = 'INVALIDNAME', FirstName = 'Error');
         Test.startTest();
        try{
            insert c;
        }catch(Exception e){
            Test.stopTest();
        }
    }
}