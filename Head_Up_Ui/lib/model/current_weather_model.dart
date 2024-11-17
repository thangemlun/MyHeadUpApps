import 'package:head_up_ui/model/current_weather_condition.dart';
import 'package:head_up_ui/model/nearest_area.dart';

class CurrentWeatherModel {
  CurrentCondition currentCondition;
	NearestArea area;

  // Constructor
  CurrentWeatherModel(this.currentCondition, this.area);

  // Manually written fromJson method
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(CurrentCondition.fromJson(json["currentCondition"]) , NearestArea.fromJson(json["area"]));
  }

  // Manually written toJson method
  Map<String, dynamic> toJson() {
    return {
      'currentCondition': currentCondition?.toJson(),
      'area': area?.toJson(),
    };
  }

}