public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer num, String Str) {
        List<Contact> c  = new List<Contact>();
        for(Integer i = 0; i < num; i++){
            Str = 'Test' + i;
            Contact contact = new Contact(FirstName = Str, LastName = Str);
            c.add(contact);
        }
        return c;
    }
}