public with sharing class DealHandler {

	public static final String DEFAULT_STATUS = 'Open';

	public void ProcessBeforeInsert(List<Deal__c> newRecords) {
		checkForStatus(newRecords);
		checkedForDuplicate(newRecords, false);
	}

	public void processBeforeUpdate(List<Deal__c> newRecords, Map<Id, Deal__c> oldRecordsMap) {
		setEndDateForClosedDeals(newRecords, oldRecordsMap, System.today());
		checkedForDuplicate(newRecords, true);
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
	private void checkedForDuplicate(List<Deal__c> newRecords, Boolean isUpdate) {

		//put current StartDate and EndDate with deal
		Set<Date> startDates = new Set<Date>();
		Set<Date> endDates = new Set<Date>();
		Set<Id> carId = new Set<Id>();

		//system.debug('existing deals = '+existingDeals);
		for (Deal__c deal : newRecords) {
			startDates.add(deal.StartDate__c);
			endDates.add(deal.EndDate__c);
			carId.add(deal.Car__c);
		}

		//check on IsEmpty
		if (!startDates.isEmpty() && !endDates.isEmpty() && !carId.isEmpty()) {
			List<Deal__c> existingDeals = [SELECT Id, StartDate__c, EndDate__c, Status__c, Car__c
					FROM Deal__c
					WHERE Car__c IN :carId];

			//put in list dates of deal and
			for (Deal__c newDeal: newRecords) {
				for (Deal__c existingDeal: existingDeals) {
					if (isUpdate) {
						if (newDeal.StartDate__c == existingDeal.StartDate__c &&
										newDeal.EndDate__c == existingDeal.EndDate__c &&
										newDeal.Car__c == existingDeal.Car__c &&
										newDeal.Id != existingDeal.Id)
						{
							//use custom label
							newDeal.addError(Label.ErrorForCarDuplication);
							continue;
						}
					} else {
						if (newDeal.Car__c == existingDeal.Car__c
							&&(
								(
									(newDeal.StartDate__c <= existingDeal.EndDate__c)
									&& (newDeal.EndDate__c > existingDeal.StartDate__c)
								)
								|| (
									(newDeal.EndDate__c > existingDeal.StartDate__c)
									&& (newDeal.StartDate__c <= existingDeal.StartDate__c)
								)
								|| (
									(newDeal.StartDate__c < existingDeal.EndDate__c)
									&& (newDeal.EndDate__c >= existingDeal.EndDate__c)
								)
							)
						){
							newDeal.addError(Label.ErrorForCarDuplication);
							continue;
						}
					}
				}
			}
		}
	}

	private void checkForStatus(List<Deal__c> newRecords) {
		Open__c CustoSettinng = Open__c.getInstance();
		String status = DEFAULT_STATUS;
		if (CustoSettinng.FieldOpen__c != NULL) {
			status = CustoSettinng.FieldOpen__c;
		}
		for (Deal__c deal : newRecords) {
			if (deal.Status__c != status) {
				deal.addError('only status ' + status + ' is allowed.');
			}
		}
	}
}