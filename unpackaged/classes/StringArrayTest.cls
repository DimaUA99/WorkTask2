public class StringArrayTest {
  
    public static List<String> generateStringArray(Integer n){
        List<string> listString = new List<String>();
        for(Integer i = 0; i<n; i++){
            listString.add('Test '+i);
            System.debug(listString[i]);
        }
        return listString;
    }
}