/**
 * Created by dkachanovskyi on 1/14/2019.
 */
public with sharing class RelatedDeals {

	public static List<Deal__c> getRelatedDeals(Map<ID, Car__c> carIds){
		Set<String> fields = new Set<String>();
		fields.add('Status__c');
		fields.add('StartDate__c');
		fields.add('EndDate__c');
		fields.add('Car__c');
		List<Deal__c> relatedDeals = CarRentDAO.relatedDeals(fields,'Open',carIds.keySet());
		return relatedDeals;
	}
}