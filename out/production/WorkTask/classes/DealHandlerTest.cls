@IsTest
public class DealHandlerTest {

	private static List<Deal__c> newDeals = new List<Deal__c>();
	private static List<Deal__c> existingDeals = new List<Deal__c>();
	private static String status;
	private static DealHandler handlerToTest = new DealHandler();

	private static void setup(Integer c) {
		//put in  custom settings DEFAULT_STATUS
		Open__c csToInsert = new Open__c(FieldOpen__c = DealHandler.DEFAULT_STATUS);
		insert csToInsert;

		validWord__c csToInsertVW = new validWord__c(Word__c = DealHandler.DEFAULT_STATUS);
		insert csToInsertVW;

		Open__c CustomSetting = Open__c.getInstance();
		status = DealHandler.DEFAULT_STATUS;
		if (CustomSetting.FieldOpen__c != NULL) {
			status = CustomSetting.FieldOpen__c;
		}
		//create NotTrue Sales__c for test
		Sales__c salesManager = new Sales__c(Name = 'TestName');
		insert salesManager;

		Car__c carId = new Car__c(Name = 'smth', Type__c = 'sedan');
		system.debug(carId);
		insert carId;

		//SUCCESS BEFORE INSERT CheckForStatus
		if (c == 0) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id,
						Status__c = status);
				newDeals.add(deal);
			}
		}
		//FAIL BEFORE INSERT CheckForStatus
		if (c == 1) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id,
						Status__c = 'Lost');
				newDeals.add(deal);
			}
		}

		// FAIL BEFORE INSERT CheckForDuplicates
		if (c == 2) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id,
						Status__c = 'Open', Car__c = carId.Id);
				newDeals.add(deal);
				existingDeals.add(deal);

			}
			existingDeals[0].StartDate__c = System.today().addDays(18);
			existingDeals[0].EndDate__c = System.today().addDays(21);

			existingDeals[1].StartDate__c = System.today().addDays(-17);
			existingDeals[1].EndDate__c = System.today().addDays(-15);

			existingDeals[2].StartDate__c = System.today().addDays(-13);
			existingDeals[2].EndDate__c = System.today().addDays(-11);

			existingDeals[3].StartDate__c = System.today().addDays(-7);
			existingDeals[3].EndDate__c = System.today().addDays(-3);

			existingDeals[4].StartDate__c = System.today().addDays(-2);
			existingDeals[4].EndDate__c = System.today().addDays(-1);

			insert existingDeals;

			newDeals[0].StartDate__c = System.today().addDays(-17);
			newDeals[0].EndDate__c = System.today().addDays(-15);

			newDeals[1].StartDate__c = System.today().addDays(-10);
			newDeals[1].EndDate__c = System.today().addDays(-5);

			newDeals[2].StartDate__c = System.today().addDays(-7);
			newDeals[2].EndDate__c = System.today().addDays(-14);

			newDeals[3].StartDate__c = System.today().addDays(-16);
			newDeals[3].EndDate__c = System.today().addDays(-8);

			newDeals[4].StartDate__c = System.today().addDays(-12);
			newDeals[4].EndDate__c = System.today().addDays(-6);
		}

		if (c == 3) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id,
						Status__c = 'Open', Car__c = carId.Id);
				newDeals.add(deal);
				existingDeals.add(deal);

			}
			existingDeals[0].StartDate__c = System.today().addDays(18);
			existingDeals[0].EndDate__c = System.today().addDays(21);

			existingDeals[1].StartDate__c = System.today().addDays(-17);
			existingDeals[1].EndDate__c = System.today().addDays(-15);

			existingDeals[2].StartDate__c = System.today().addDays(-13);
			existingDeals[2].EndDate__c = System.today().addDays(-11);

			existingDeals[3].StartDate__c = System.today().addDays(-7);
			existingDeals[3].EndDate__c = System.today().addDays(-3);

			existingDeals[4].StartDate__c = System.today().addDays(-2);
			existingDeals[4].EndDate__c = System.today().addDays(-1);

			insert existingDeals;

			newDeals[0].StartDate__c = System.today().addDays(-17);
			newDeals[0].EndDate__c = System.today().addDays(-15);

			newDeals[1].StartDate__c = System.today().addDays(-10);
			newDeals[1].EndDate__c = System.today().addDays(-5);

			newDeals[2].StartDate__c = System.today().addDays(-7);
			newDeals[2].EndDate__c = System.today().addDays(-14);

			newDeals[3].StartDate__c = System.today().addDays(-16);
			newDeals[3].EndDate__c = System.today().addDays(-8);

			newDeals[4].StartDate__c = System.today().addDays(-12);
			newDeals[4].EndDate__c = System.today().addDays(-6);
		}

		if (c == 4) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id, Status__c = 'Open',
						StartDate__c = System.today().addDays(-2),
						EndDate__c = System.today().addDays(-1),
						Car__c = carId.Id);
				existingDeals.add(deal);
				newDeals.add(deal);
			}
			insert existingDeals;
		}
		if (c == 5) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id, Status__c = 'Open',
						StartDate__c = System.today().addDays(-10),
						EndDate__c = System.today(),
						Car__c = carId.Id);
				existingDeals.add(deal);
				newDeals.add(deal);
			}
			insert existingDeals;
		}

	}

	@isTest static void TestProcessBeforeInsertCheckForStatusSuccess() {
		setup(0);
		Test.StartTest();
		handlerToTest.checkForStatus(newDeals);
		Test.StopTest();
		System.assertEquals(handlerToTest.errorText, '');
	}

	@isTest static void TestProcessBeforeInsertCheckForStatusFail() {
		setup(1);
		Test.StartTest();
		handlerToTest.checkForStatus(newDeals);
		Test.StopTest();
		System.assertEquals(handlerToTest.errorText, 'only status ' + status + ' is allowed.');
	}

	@isTest static void TestProcessBeforeInsertCheckedForDuplicateSuccess() {
		setup(2);
		handlerToTest.checkedForDuplicate(newDeals, false);
	}

	@isTest static void TestProcessBeforeInsertCheckedForDuplicateFail() {
		setup(3);
		Test.startTest();
		handlerToTest.checkedForDuplicate(newDeals, false);
		Test.stopTest();
		System.assertEquals(handlerToTest.errorText, Label.ErrorForCarDuplication);
	}

	@isTest static void TestProcessBeforeUpdateCloseDateSuccess() {
		setup(4);
		newDeals = [SELECT Id, Status__c, EndDate__c FROM Deal__c];
		newDeals[0].Status__c = 'Lost';
		newDeals[1].Status__c = 'Won';
		Test.startTest();

		handlerToTest.setEndDateForClosedDeals(newDeals,
				new Map<Id, Deal__c>(existingDeals), System.today());
		Test.stopTest();
		system.assertEquals(newDeals[0].EndDate__c, System.today());
		system.assertEquals(newDeals[1].EndDate__c, System.today());
		system.assertNotEquals(newDeals[2].EndDate__c, System.today());
		//System.assertEquals(handlerToTest.errorText, '');
	}

	@isTest static void TestProcessBeforeUpdateCloseDateFail() {
		setup(5);
		newDeals = [SELECT Id, Status__c, EndDate__c FROM Deal__c];
		newDeals[0].Status__c = 'Lost';
		newDeals[1].Status__c = 'Open';
		Test.startTest();
		handlerToTest.setEndDateForClosedDeals(newDeals,
				new Map<Id, Deal__c>(existingDeals), System.today());
		Test.stopTest();

	}

	@isTest static void TestProcessBeforeCheckedForDuplicateSuccess() {
		setup(5);
		Test.startTest();
		newDeals = [SELECT Id, Status__c, EndDate__c, StartDate__c, Car__c FROM Deal__c];
		Test.stopTest();
		handlerToTest.checkedForDuplicate(newDeals, false);
	}

	@isTest static void TestProcessBeforeCheckedForDuplicateFail() {
		setup(5);
		Test.startTest();
		newDeals = [SELECT Id, Status__c, EndDate__c, StartDate__c, Car__c FROM Deal__c];
		Test.stopTest();
		handlerToTest.checkedForDuplicate(newDeals, true);

	}

}