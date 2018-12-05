trigger TriggerForCar on Car__c (before delete) {
	//Trigger.new -> list new records
	//Trigger.newMap -> man new records <Id, sObject>
    //we get all Ids of Cars -> a) for(Car__c c:Trigger.Old){carIds.add(c.Start_date__c);carIds.add(c.End_date__c);}
    //							b) carIds = Trigger.oldMap.keySet();   
     if (Trigger.isBefore){
        if (Trigger.isDelete){
            List<Deal__c> relatedDeals = [SELECT Id, Status__c 
                                          FROM Deal__c 
                                          WHERE Status__c = 'Open'
                                  		  AND Car__c IN :Trigger.oldMap.keySet()];
            for(Deal__c deal: relatedDeals){
                deal.Status__c = 'Lost';
            }
            
            update relatedDeals;
        }
    }
    if (Trigger.isAfter){
        if (Trigger.isInsert){
            
        }
    }
    
}