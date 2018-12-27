public class ControllerForDeals {
	private final Deal__c deal;
	private static final String status = 'Open';
	private static List<Deal__c> relatedDeals {get;set;}

	public ControllerForDeals(ApexPages.StandardController stdController) {

		this.deal = (Deal__c)stdController.getRecord();
	}

	//get related deals with status = Open
	public List<Deal__c> getDeals() {
		relatedDeals=[SELECT StartDate__c, EndDate__c, Car__c, Status__c
		  FROM Deal__c
		  WHERE Status__c = :status];
		return relatedDeals;

	}
}