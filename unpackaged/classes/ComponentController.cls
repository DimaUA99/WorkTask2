public with sharing class ComponentController {

	public Id carsId{get;set;}
	public LIst<Deal__c> deals{
		get{
			deals =[SELECT Car__c, StartDate__c, EndDate__c, Status__c
			FROM Deal__c
			WHERE Car__c = :carsId];
			return deals;
		}set;
}
}