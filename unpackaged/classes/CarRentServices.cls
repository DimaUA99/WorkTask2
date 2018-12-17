public class CarRentServices {

	public static Boolean checkDealsOverlapDates(Deal__c newDeal, Deal__c existingDeal) {

		// return check deals
		return (((newDeal.Car__c == existingDeal.Car__c) &&
				(newDeal.StartDate__c <= existingDeal.EndDate__c) &&
				(newDeal.EndDate__c > existingDeal.StartDate__c) ||
						(newDeal.EndDate__c > existingDeal.StartDate__c) &&
						(newDeal.StartDate__c <= existingDeal.StartDate__c) ||
						(newDeal.StartDate__c < existingDeal.EndDate__c) &&
						(newDeal.EndDate__c >= existingDeal.EndDate__c)));
	}





	public static void upDateDeals(List<Deal__c> dealsToInsert) {

	}
}