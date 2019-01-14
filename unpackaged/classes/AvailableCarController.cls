/**
 * Created by dkachanovskyi on 1/9/2019.
 */
public  class AvailableCarController {

	@AuraEnabled
		public static List<Car__c> getAvailableCars(){
		List<Car__c> availableCars = [SELECT Name, Id, Type__c, Photo__c,IsValidForRent__c
		 FROM Car__c
		WHERE IsValidForRent__c = true];

		return availableCars;
	}
}