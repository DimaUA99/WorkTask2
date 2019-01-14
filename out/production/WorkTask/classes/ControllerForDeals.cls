//public class ControllerForCar {
//	private final Car__c car;
//	public static Id carId;
//	private static final String STATUS_OPEN = 'Open';
//	private static List<Deal__c> relatedDeals {
//		get{
//			relatedDeals = [SELECT Car__c, StartDate__c, EndDate__c, Status__c
//					FROM Deal__c
//					WHERE Car__c = :carId
//			AND Status__c =: STATUS_OPEN];
//			return relatedDeals;
//		}
//		set;
//	}
//	public List<Deal__c> getRelatedDeals(){
//		return relatedDeals;
//	}
//	public ControllerForDeals(ApexPages.StandardController stdController) {
//		this.car = (Car__c.Id)stdController.getId();
//	}
//}