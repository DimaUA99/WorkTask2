/**
 * Created by dkachanovskyi on 12/5/2018.
 */
public class DealHandler {


	public void ProcessBeforeInsert(List<Deal__c> triggerNew) {
		checkedForDuplicate(triggerNew, false);
	}

	public void processBeforeUpdate(List<Deal__c> triggerList, Map<Id, Deal__c> triggerOld) {
		setEndDateForClosedDeals(triggerList, triggerOld, System.today());
		checkedForDuplicate(triggerList, true);
	}


	private void setEndDateForClosedDeals(List<Deal__c> newRecords,
										  Map<Id, Deal__c>oldRecords,
										  Date dateToSet) {
		for (Deal__c newDeal: newRecords) {
			Deal__c oldDeal = oldRecords.get(newDeal.Id);
			//check on status and put current date in endDate
			if (newDeal.Status__c != oldDeal.Status__c &&
					(newDeal.Status__c == 'Won' || newDeal.Status__c == 'Lost')) {

				newDeal.EndDate__c = dateToSet;
			}
		}

	}

	//watch what would did not have duplicate
	private void checkedForDuplicate(List<Deal__c> triggerNew, Boolean isUpdate) {

		//put current StartDate and EndDate with deal
		Set<Date> startDates = new Set<Date>();
		Set<Date> endDates = new Set<Date>();
		Set<Id> carId = new Set<Id>();

		for (Deal__c deal : triggerNew) {
			startDates.add(deal.StartDate__c);
			endDates.add(deal.EndDate__c);
			carId.add(deal.Car__c);
			//check on IsEmpty
			if (!startDates.isEmpty() && endDates.size() > 0) {
				//put in list dates of deal and
				List<Deal__c> existingDeals = [SELECT Id, StartDate__c, EndDate__c, Status__c, Car__c
				FROM Deal__c
				WHERE StartDate__c IN :startDates
				AND EndDate__c IN :endDates
				AND Car__c IN :carId];

				for (Deal__c newDeal: triggerNew) {
					for (Deal__c existingDeal: existingDeals) {
						if (newDeal.StartDate__c == existingDeal.StartDate__c &&
								newDeal.EndDate__c == existingDeal.EndDate__c &&
										newDeal.Car__c == existingDeal.Car__c &&
										(isUpdate == true )|| false)
						{

							newDeal.addError(Label.ErrorForCarDuplication);
							continue;
						}
					}
				}
			}
		}
	}
}