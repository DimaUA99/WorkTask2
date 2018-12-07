public class CarRentDAO {

    public List<Deal__c> getWonDeals(DateTime StartDate, DateTime EndDate){
        List<Deal__c> listDeal = new List<Deal__c>();
        for(Deal__c deal:listDeal){
            if(deal.StartDate__c == StartDate &&
                            deal.EndDate__c == EndDate &&
                            deal.Status__c == 'Won'){
                listDeal.add(deal);
            }
        }
        return listDeal;
    }
    
    public Map<Id,Integer> getWonDealsBySalesRepIds (Set<Id> salesReplds){
        Map<Id,Integer> mapRepAndWon = new Map<Id, Integer>();
        return mapRepAndWon;
    }
    public List<Deal__c> getCarsAvailableForDeal(Date dealStart, Date dealEnd){
        List<Deal__c> listDeal = new List<Deal__c>();
        for(Deal__c deal : listDeal){
            if(deal.StartDate__c == dealStart && deal.EndDate__c == dealEnd){
                deal.Status__c = 'Open';
                listDeal.add(deal);
            }
        }
        return listDeal;
    }
   // public Map<Id, Integer> getCarRentStatistic(){
    //    
  //  }
   // public SalesRepresentative__c getTopRatedSalesRepOfYear(Id carId){
   //     
   // }
}