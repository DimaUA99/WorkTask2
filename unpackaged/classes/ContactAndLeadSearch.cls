public class ContactAndLeadSearch {

    public static List<List<SObject>> searchContactsAndLeads(String lastName){
        
        List<List<SObject>> searchList = [FIND :lastName IN NAME FIELDS
                                         RETURNING Contact (Name), Lead(LastName)];
            return searchList;
    }
}