public class InsertAcc {
 
    Account account = new Account(Name = 'SFDC Account');
    public Contact mario = new Contact(
        FirstName = 'Mario',
        LastName = 'Ruiz',
    	Phone = '415.555.1212',
        AccountID = account.ID);
    
    public void TheRelatedRecord(){
       insert account;
       ID AccoundID = account.ID;
        insert mario;
    } 
}