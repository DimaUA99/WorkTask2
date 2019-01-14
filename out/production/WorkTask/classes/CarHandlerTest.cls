@IsTest
public class CarHandlerTest {

	private static List<Car__c> newCars = new List<Car__c>();
	private static final String STATUS_LOST = 'Lost';
	private static CarHandler handlerToTest = new CarHandler();

	public static void setup(Integer c) {

		validWord__c csToInsertVW = new validWord__c(Word__c = DealHandler.DEFAULT_STATUS);
		insert csToInsertVW;

		Sales__c salesManager = new Sales__c(Name = 'TestName');
		insert salesManager;

		ObjectForStatus__c customSet = new ObjectForStatus__c(Status_Lost__c ='Lost');
		insert customSet;
		if (c == 0) {
			Car__c car = new Car__c(Name = 'smth', Type__c = 'sedan');
			Car__c car2 = new Car__c(Name = 'Audi', Type__c = 'sedan');

			insert car;
			insert car2;
			newCars.add(car);
			newCars.add(car2);

			Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id, Car__c = newCars[0].Id,
					StartDate__c = System.today().addDays(-20),
					EndDate__c = System.today().addDays(29));

			Deal__c deal2 = new Deal__c(Sales_Manager__c = salesManager.Id, Car__c = newCars[1].Id,
					StartDate__c = System.today().addDays(-10),
					EndDate__c = System.today().addDays(10));

			insert deal;
			insert deal2;
		}

		if (c == 1) {
			Car__c car = new Car__c(Name = 'smth', Type__c = 'sedan');
			Car__c car2 = new Car__c(Name = 'smth2', Type__c = 'sedan');
			newCars.add(car);
			newCars.add(car2);
		}

	}

	@isTest static void TestProcessBeforeUpdateDealSuccess() {
		setup(0);
		Test.startTest();
		handlerToTest.processBeforeDelete(new Map<Id, Car__c>(newCars));
		Test.stopTest();
		List<Deal__c> listDeals = [SELECT Id, Car__c, Status__c FROM Deal__c];
		System.assertEquals(STATUS_LOST, listDeals[0].Status__c);

	}

	@isTest static void TestProcessBeforeUpdateDealFail() {
		setup(1);
		Test.startTest();
		try	{
			handlerToTest.processBeforeDelete(new Map<Id, Car__c>(newCars));
		}catch (Exception e) {
			System.debug(e);
		}
		Test.stopTest();
	}
}