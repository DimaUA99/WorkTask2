trigger TriggerForDeal on Deal__c (before insert, before update) {
	DealHandler handler = new DealHandler();

	if (Trigger.isBefore) {

		if (Trigger.isInsert) {
			handler.ProcessBeforeInsert(Trigger.new);
		}
		if (Trigger.isUpdate) {
			handler.processBeforeUpdate(Trigger.new, Trigger.oldMap);

		}
	}

	}
