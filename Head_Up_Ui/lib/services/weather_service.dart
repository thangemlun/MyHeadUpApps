import 'package:head_up_ui/model/current_weather_model.dart';

abstract class WeatherService {
  Future<CurrentWeatherModel> getCurrentWeatherByCity(String city);
}