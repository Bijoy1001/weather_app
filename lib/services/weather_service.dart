import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
    static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
    final String apiKey;

    WeatherService (this.apiKey);

    future<weather>getWeather(String cityName) async {
        final response = await http
        .get(url.parse('lat=44.34&lon=10.99&appid={5b641d91ea423c08f9696ec51ba2de77}'));

        if (response.statusCode == 200) {
            return weather.fromJson(jsonDecode(response.body));
        } 
        else {
            throw Exception('Failed to load weather data');
        }
    }

    Future<String> getCurrentCity() async {
        locationPermission permissin = await Geolocator.checkPermission();
        if (permissin == LocationPermission.denied){
            permissin = await Geolocator.requestPermmion();
        }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    

    List<Placemark> Placemark =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
    }

}