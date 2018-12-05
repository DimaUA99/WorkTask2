public class TemperatureConverter {

    public static Decimal FahrenheitToCelsius(Decimal dec){
        
        Decimal d = (dec - 32) * 5/9;
        return d.setScale(2);
    }
}