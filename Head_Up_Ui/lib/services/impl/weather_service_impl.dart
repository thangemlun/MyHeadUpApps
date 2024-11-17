import 'package:head_up_ui/environment/app_constant.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/model/current_weather_condition.dart';
import 'package:head_up_ui/model/current_weather_model.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/services/weather_service.dart';
import 'package:head_up_ui/util/http_util.dart';

class WeatherServiceImpl implements WeatherService {

  static final String WEATHER_API = "/api/weather";

  @override
  Future<CurrentWeatherModel> getCurrentWeatherByCity(String city) async {
      Response? response;
      response = (await HttpUtil<CurrentCondition>().get("${AppConstant.HeadUpBeHost}${WEATHER_API}/${city}"));
      return CurrentWeatherModel.fromJson(response.data as Map<String,dynamic>);
  }
}