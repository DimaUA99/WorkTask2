trigger TriggerForDeal on Deal__c (before insert, before update) {
	if (Trigger.isBefore){
        if (Trigger.isInsert){
        	
            Set<Date> startDates = new Set<Date>();
    		Set<Date> endDates = new Set<Date>();
    		
            //we collect start/end dates of trigger.new
            for(Deal__c deal:Trigger.new){
                if(deal.Status__c == 'Won' || deal.Status__c == 'Lost'){
                    startDates.add(deal.StartDate__c);
                    endDates.add(deal.EndDate__c);
                }
            }
            if(startDates.size() > 0 && endDates.size() > 0){
                List<Deal__c> existingDeals = [SELECT Id, StartDate__c, EndDate__c, Status__c
                                    From   Deal__c 
                                    WHERE StartDate__c IN: StartDates 
                                    AND EndDate__c IN: EndDates
                                    AND (Status__c = 'Won' OR Status__c = 'Lost')
                                   ];
                for(Deal__c newDeal:Trigger.new){
                    for(Deal__c existingDeal : existingDeals)
                    {
                        if(newDeal.StartDate__c == existingDeal.StartDate__c
                           && newDeal.EndDate__c == existingDeal.EndDate__c
                           && (newDeal.Status__c == 'Won' || newDeal.Status__c == 'Lost')
                          ){
                              newDeal.addError('We already have such deal. It\'s Id = '+existingDeal.Id);
                              continue;
                          }                    
                                            
                    }
                }   
                
            }   		
        }
        if (Trigger.isUpdate){
            for(Deal__c newDeal:Trigger.new){
                
                Deal__c oldDeal = Trigger.oldMap.get(newDeal.Id);
                if(newDeal.Status__c != oldDeal.Status__c 
                   && (newDeal.Status__c == 'Won' || newDeal.Status__c == 'Lost')){
                   		newDeal.EndDate__c = System.today();
                }
                
                
                
            }
            
        }
    }
    if (Trigger.isAfter){
        if (Trigger.isUpdate){
            
            
        }
    }
}