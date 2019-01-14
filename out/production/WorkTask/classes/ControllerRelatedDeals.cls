/**
 * Created by dkachanovskyi on 12/31/2018.
 */
public class ControllerRelatedDeals {

	private Id carId;
	private static final String STATUS_OPEN = 'Open';
	public ControllerRelatedDeals(ApexPages.StandardController stdController) {
		this.carId = stdController.getId();
	}
	public  List<Deal__c> relatedDeals {
		get{
			relatedDeals = [SELECT Car__c, StartDate__c, EndDate__c, Status__c
					FROM Deal__c
					WHERE Car__c = :carId
			AND Status__c =: STATUS_OPEN];
			return relatedDeals;
		}
		set;
	}



}