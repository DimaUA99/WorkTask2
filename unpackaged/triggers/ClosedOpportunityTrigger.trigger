trigger ClosedOpportunityTrigger on Opportunity (before insert) {

    List<Task> listTask = new List<Task>();
    for(Opportunity opp:Trigger.new){
        if(opp.StageName == 'Closed Won'){
            Task task = new Task();
            task.Subject = 'Follow Up Test Task';
            task.WhatId = opp.Id;
            listTask.add(task);
        }
    }
    if(listTask.size() > 0){
   insert listTask;
        
    }
}