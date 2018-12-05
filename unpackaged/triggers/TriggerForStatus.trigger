Trigger TriggerForStatus on Deal__c (before insert) {

    List<Deal__c> listDeal = new List<Deal__c>();
    for(Deal__c deal: Trigger.New){
        if(deal.Status__c == 'Won__c' && deal.Status__c == 'Open__c'){
            deal.addError('Error and samething');
            listDeal.add(deal);
        }
    }
    insert listDeal;
    
}