public class CarRentDAO {

    public List<Deal__c> getWonDeals(DateTime StartDate, DateTime EndDate){
        List<Deal__c> listDeal = new List<Deal__c>();
        for(Deal__c deal:listDeal){
            if(StartDate != EndDate && deal.Status__c == 'Won'){
                listDeal.add(deal);
            }
        }
        return listDeal;
    }
    
    public Map<Id,Integer> getWonDealsBySalesRepIds (Set<Id> salesReplds){
        Map<Id,Integer> mapRepAndWon = new Map<Id, Integer>();
        return mapRepAndWon;
    }
    public List<Car__c> getCarsAvailableForRent(Date rentStart, Date rentEnd){
        List<Car__c> listCar = new List<Car__c>();
        for(Car__c car : listCar){
            
        }
        return listCar;
    }
   // public Map<Id, Integer> getCarRentStatistic(){
    //    
  //  }
   // public SalesRepresentative__c getTopRatedSalesRepOfYear(Id carId){
   //     
   // }
}