import 'package:head_up_ui/model/weather_city.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/services/master_data_service.dart';
import 'package:head_up_ui/util/http_util.dart';

class MasterDataServiceImpl extends MasterDataService {

  static final String MASTER_API = "/api/master";
  static final String CITY = "/city";

  @override
  Future<List<WeatherCity>> getAllCities() async {
    List<WeatherCity> result = [];
    Response resp = (await HttpUtil().get("${MASTER_API + CITY}/all"));
    if (resp != null) {
      List<dynamic> items = resp.data as List<dynamic>;
      result = items.map((item) {
        WeatherCity city = WeatherCity.fromJson(item);
        return city;
      }).toList();
    }
    return result;
  }
}