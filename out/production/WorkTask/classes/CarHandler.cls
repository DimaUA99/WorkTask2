/**
 * Created by dkachanovskyi on 12/5/2018.
 */
public class CarHandler {
	public static final String STATUS_LOST = 'Lost';
	public void processBeforeDelete(Map<Id, Car__c> oldRecords){
		updateDeal(oldRecords);
	}

	private void updateDeal(Map<Id, Car__c> cars) {

		Set<String> fields = new Set<String>();
		fields.add('Status__c');
		fields.add('StartDate__c');
		fields.add('EndDate__c');
		fields.add('Car__c');

		List<Deal__c> relatedDeals = CarRentDAO.relatedDeals(fields, '', cars.keySet());
		//use custom setting for status lost

		ObjectForStatus__c customSet = ObjectForStatus__c.getInstance();
		String status = STATUS_LOST;

		if (customSet.Status_Lost__c != NULL) {
			status = customSet.Status_Lost__c;
		}
		for(Deal__c deal: relatedDeals){
				deal.Status__c = status;
		}
		CarRentServices.updateDeals(relatedDeals);

	}


}