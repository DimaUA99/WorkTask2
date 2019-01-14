public class CarRentDAO {

   public static List<Deal__c> relatedDeals (Set<String> fields, String status, Set<Id> carIds){

       List<Deal__c> relatedDeals = new List<Deal__c>();
       String queryString = 'SELECT Id ';
       if(!fields.isEmpty()){
            queryString += ',' + String.join(new List<String>(fields), ', ');
       }
       queryString += ' FROM Deal__c';
       queryString += ' WHERE ';
       queryString += ' Car__c IN :carIds';
       if(!String.isBlank(status)){
           queryString += ' AND Status__c = \''+status+'\'';
       }
       System.debug('query String' + queryString);

       relatedDeals = Database.query(queryString);

       return relatedDeals;
   }
}