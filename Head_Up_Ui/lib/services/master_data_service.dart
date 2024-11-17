import 'package:head_up_ui/model/weather_city.dart';

abstract class MasterDataService {
  Future<List<WeatherCity>> getAllCities();
}