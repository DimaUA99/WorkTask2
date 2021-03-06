/**
 * Created by dkachanovskyi on 1/2/2019.
 */

@IsTest
public class ControllerForDealsTest {

    private static List<Deal__c> existingDeals = new List<Deal__c>();
//  private static List<Deal__c> newDeals = new List<Deal__c>();
    private static List<Car__c> idCars =new List<Car__c>();
    private static ApexPages.StandardController sc;
    public static ControllerRelatedDeals controller;

    private static void setup(Integer c) {

        validWord__c csToInsertVW = new validWord__c(Word__c = DealHandler.DEFAULT_STATUS);
        insert csToInsertVW;

        Sales__c salesManager = new Sales__c(Name = 'TestName');
        insert salesManager;

        Car__c carId = new Car__c(Name = 'smth', Type__c = 'sedan');
        insert carId;
        idCars.add(carId);


        sc = new ApexPages.StandardController(carId);
        controller = new ControllerRelatedDeals(sc);


        if (c == 0) {
            for (integer i = 0;i < 5;i++) {
                Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id, Status__c = 'Open',
                        StartDate__c = System.today().addDays(-2),
                        EndDate__c = System.today().addDays(-1),
                        Car__c = carId.Id);
                existingDeals.add(deal);
            }
            insert existingDeals;
        }
    }
    @isTest static void TestProcessDisplayAllDealsSuccess() {
        setup(0);
        Test.startTest();
        controller.relatedDeals =[
        SELECT Sales_Manager__c, Status__c,StartDate__c,  EndDate__c,  Car__c
        FROM Deal__c
        WHERE Car__c = :idCars];
        Test.stopTest();
    }
}