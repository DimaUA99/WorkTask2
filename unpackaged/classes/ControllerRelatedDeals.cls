/**
 * Created by dkachanovskyi on 12/31/2018.
 */
public with sharing class ControllerRelatedDeals {

	private Id carId;
	private static final String STATUS_OPEN = 'Open';
	public ControllerRelatedDeals(ApexPages.StandardController stdController) {
		carId = stdController.getId();
	}

	public List<Deal__c> relatedDeals {

		get{
			relatedDeals = [SELECT Car__c, StartDate__c, EndDate__c, Status__c
					FROM Deal__c
					WHERE Car__c = :carId
			AND Status__c =: STATUS_OPEN];
			return relatedDeals;
		}
		set;
	}

	@AuraEnabled
	public static List<Deal__c> getAuraRelatedDeals(Id carId) {
		Set<Id> carIds = new Set<Id>();
		carIds.add(carId);
		Set<String> fields = new Set<String>();
		fields.add('Status__c');
		fields.add('StartDate__c');
		fields.add('EndDate__c');
		fields.add('Car__c');

		List<Deal__c> relatedDeals = new List<Deal__c>();
		relatedDeals = CarRentDAO.relatedDeals(fields,STATUS_OPEN, carIds);
		return relatedDeals;
	}

}