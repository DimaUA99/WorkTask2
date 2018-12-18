/**
 * Created by dkachanovskyi on 12/17/2018.
 */
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

		Open__c CustomSetting = Open__c.getInstance();
		status = DealHandler.DEFAULT_STATUS;
		if (CustomSetting.FieldOpen__c != NULL) {
			status = CustomSetting.FieldOpen__c;
		}
		//create NotTrue Sales__c for test
		Sales__c salesManager = new Sales__c(Name = 'TestName');
		insert salesManager;

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

		Car__c carId = new Car__c(Type__c = 'sedan');
		insert carId;


		//FAIL BEFORE INSERT CheckForDuplicates
		if (c == 2) {
			for (integer i = 0;i < 5;i++) {
				Deal__c deal = new Deal__c(Sales_Manager__c = salesManager.Id,
						Status__c = 'Lost', Car__c = carId.Id);
				newDeals.add(deal);
				existingDeals.add(deal);

			}
			//TODO fix bug (Error specify the metadata file)
			existingDeals.get(0).StartDate__c = System.today().addDays(18);
			existingDeals.get(0).EndDate__c = System.today().addDays(21);

			existingDeals.get(1).StartDate__c = System.today().addDays(-17);
			existingDeals.get(1).EndDate__c = System.today().addDays(-15);

			existingDeals.get(2).StartDate__c = System.today().addDays(-13);
			existingDeals.get(2).EndDate__c = System.today().addDays(-11);

			existingDeals.get(3).StartDate__c = System.today().addDays(-7);
			existingDeals.get(3).EndDate__c = System.today().addDays(-3);

			existingDeals.get(4).StartDate__c = System.today().addDays(-2);
			existingDeals.get(4).EndDate__c = System.today().addDays(-1);

			newDeals.get(0).StartDate__c = System.today().addDays(-17);
			newDeals.get(0).EndDate__c = System.today().addDays(-15);

			newDeals.get(1).StartDate__c = System.today().addDays(-10);
			newDeals.get(1).EndDate__c = System.today().addDays(-5);

			newDeals.get(2).StartDate__c = System.today().addDays(-7);
			newDeals.get(2).EndDate__c = System.today().addDays(-14);

			newDeals.get(3).StartDate__c = System.today().addDays(-16);
			newDeals.get(3).EndDate__c = System.today().addDays(-8);

			newDeals.get(4).StartDate__c = System.today().addDays(-12);
			newDeals.get(4).EndDate__c = System.today().addDays(-6);



		}
	}


	@isTest static void TestProcessBeforeInsertCheckForStatusSuccess() {
		setup(0);
		Boolean errorPresent = false;
		Test.StartTest();

		handlerToTest.checkForStatus(newDeals);

		Test.StopTest();
		System.assertEquals(handlerToTest.errorText, '');
	}

	@isTest static void TestProcessBeforeInsertCheckForStatusFail() {
		setup(1);
		Boolean errorPresent = false;
		Test.StartTest();

		handlerToTest.checkForStatus(newDeals);

		Test.StopTest();
		System.assertEquals(handlerToTest.errorText, 'only status ' + status + ' is allowed.');
	}
	@isTest static void TestProcessBeforeInsertCheckedForDuplicateSuccess() {
		setup(2);
		Boolean errorPresent = true;
		Test.startTest();
		handlerToTest.checkedForDuplicate(newDeals, false);
		Test.stopTest();

	}
	@IsTest static void TestProcessBeforeInsertCheckedForDuplicateFail(){
	setup(2);
		Boolean errorPresent = false;
		Test.startTest();
		handlerToTest.checkedForDuplicate(newDeals, true);
		Test.stopTest();

	}
}