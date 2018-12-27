public class ControllerForDeals {
	private final List<Deal__c> deal{
		get;set;
	}
	private final Car__c car;
	private static Set<Id> carId;
	private static final String status = 'Open';
	private static List<Deal__c> relatedDeals {
		get{
			relatedDeals = [SELECT Car__c, StartDate__c, EndDate__c, Status__c
					FROM Deal__c
					WHERE Car__c = :carId
			AND Status__c =: status];
			return relatedDeals;
		}
		set;
	}
	public List<Deal__c> getRelatedDeals(){
	return relatedDeals;
	}

	public ControllerForDeals(ApexPages.StandardController stdController) {
		this.car = (Car__c)stdController.getRecord();
	}


}