/**
 * Created by dkachanovskyi on 12/5/2018.
 */
public class CarHandler {
	public void processBeforeDelete(Map<Id, Car__c> oldTrigger){
		updateDeal(oldTrigger);
	}


	private void updateDeal(Map<Id, Car__c> triggerOld){

		List<Deal__c> relatedDeals = [SELECT id, Deal__c.Status__c
		FROM Deal__c
				WHERE Status__c = 'Open'
		AND Car__c	IN : triggerOld.keySet()];

		for(Deal__c deal: relatedDeals){
			if(deal.Status__c == 'Open'){
				deal.Status__c = 'Lost';
			}
		}
		update relatedDeals;
	}


}