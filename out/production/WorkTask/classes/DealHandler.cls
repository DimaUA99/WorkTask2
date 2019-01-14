public with sharing class DealHandler {

	public static final String DEFAULT_STATUS = 'Open';
	@TestVisible
	private String errorText = '';

	public void ProcessBeforeInsert(List<Deal__c> newRecords) {
		checkForStatus(newRecords);
		checkedForDuplicate(newRecords, false);
	}

	public void processBeforeUpdate(List<Deal__c> newRecords, Map<Id, Deal__c> oldRecordsMap) {
		setEndDateForClosedDeals(newRecords, oldRecordsMap, System.today());
		checkedForDuplicate(newRecords, true);
	}

	@TestVisible
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

	//watch what would did not have duplication
	@TestVisible
	private void checkedForDuplicate(List<Deal__c> newRecords, Boolean isUpdate) {
		//put current car in set carId
		Set<Id> carId = new Set<Id>();
		for (Deal__c deal : newRecords) {
			carId.add(deal.Car__c);
		}
		//check on IsEmpty
		if (!carId.isEmpty()) {

			Set<String> fields = new Set<String>();

			fields.add('Status__c');
			fields.add('StartDate__c');
			fields.add('EndDate__c');
			fields.add('Car__c');
			List<Deal__c> existingDeals = CarRentDAO.relatedDeals(fields, '', carId);

			//check on duplication and period Dates
			for (Deal__c newDeal: newRecords) {
				for (Deal__c existingDeal: existingDeals) {
					if (isUpdate) {
						system.debug('newDeal = '+newDeal);
						system.debug('existingDeal = '+existingDeal);
						system.debug('CarRentServices.checkDealsOverlapDates(newDeal, existingDeal) = '+CarRentServices.checkDealsOverlapDates(newDeal, existingDeal));
						system.debug('newDeal.Id != existingDeal.Id = '+(newDeal.Id != existingDeal.Id));
						if(CarRentServices.checkDealsOverlapDates(newDeal, existingDeal)
								&& newDeal.Id != existingDeal.Id){
							newDeal.addError(Label.ErrorForCarDuplication);
							errorText = Label.ErrorForCarDuplication;
							continue;
						}

					} else {
						if(CarRentServices.checkDealsOverlapDates(newDeal, existingDeal)){
							newDeal.addError(Label.ErrorForCarDuplication);
							errorText = Label.ErrorForCarDuplication;
							continue;
						}
					}
				}
			}
		}
	}
	@TestVisible
	private void checkForStatus(List<Deal__c> newRecords) {
		//use custom setting for status open
		Open__c CustomSetting = Open__c.getInstance();
		String status = DEFAULT_STATUS;
		if (CustomSetting.FieldOpen__c != NULL) {
			status = CustomSetting.FieldOpen__c;
		}
		for (Deal__c deal : newRecords) {
			if (deal.Status__c != status) {
				deal.addError('only status ' + status + ' is allowed.');
				errorText = 'only status ' + status + ' is allowed.';
			}
		}
	}
}