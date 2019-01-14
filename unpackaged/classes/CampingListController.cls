public  class CampingListController {

	@AuraEnabled
	public static void saveItem (Camping_Item__c campingItem) {
		try{
			insert campingItem;
		}catch (Exception e){
			System.debug(e.getMessage());
		}

	}

	@AuraEnabled
	public static List<Camping_Item__c> getItems() {
		List<Camping_Item__c> campingItems = [SELECT Id,Name,Price__c,Packed__c,Quantity__c FROM Camping_Item__c];
		return campingItems;
	}


}