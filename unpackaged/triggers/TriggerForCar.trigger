trigger TriggerForCar on Car__c (before delete) {
	//Trigger.new -> list new records
	//Trigger.newMap -> man new records <Id, sObject>
	//we get all Ids of Cars -> a) for(Car__c c:Trigger.Old){carIds.add(c.Start_date__c);carIds.add(c.End_date__c);}
	//							b) carIds = Trigger.oldMap.keySet();
	CarHandler handler = new CarHandler();
	if (Trigger.isBefore) {
		if (Trigger.isDelete) {
			handler.processBeforeDelete(Trigger.oldMap);
		}
	}
}