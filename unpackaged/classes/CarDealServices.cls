public class CarDealServices {

    public List<Deal__c>  filterFinished(){
        List<Deal__c> deal = new List<Deal__c>();
        for(Deal__c d : deal){
            if(d.Status__c == 'Won'|| d.Status__c == 'Lost'){
                deal.add(d);
            }
        }
        return deal;
    }
    public void setEndDate(){
        List<Deal__c> deals = new List<Deal__c>();
        for(Deal__c deal : deals){
            deal.EndDate__c = System.today();
        }
    }
    
}