/**
 * Created by dkachanovskyi on 12/11/2018.
 */
public class test {

	public test(){
		List<Deal__c> newRecords =[SELECT Id, deal__c FROM Deal__c];
		Map<Id, Deal__c> oldRecords = new Map<Id, Deal__c>(newRecords);




	}
}