class CurrentCondition {

  static final CurrentCondition demoData = CurrentCondition(
    tempC: "32",
    tempF: "90",
    pressure: "1004",
    feelsLikeC: "40",
    feelsLikeF: "104",
    weatherDesc: List.of([WeatherDesc(value: "Partly cloudy")])
  );

  String? feelsLikeC;
  String? feelsLikeF;
  String? cloudCover;
  String? humidity;
  String? localObsDateTime;
  String? observationTime;
  String? precipInches;
  String? precipMM;
  String? pressure;
  String? pressureInches;
  String? tempC;
  String? tempF;
  String? uvIndex;
  String? visibility;
  String? visibilityMiles;
  String? weatherCode;
  List<WeatherDesc>? weatherDesc;
  List<WeatherIconUrl>? weatherIconUrl;
  String? winddir16Point;
  String? winddirDegree;
  String? windspeedKmph;
  String? windspeedMiles;

  CurrentCondition({
    this.feelsLikeC,
    this.feelsLikeF,
    this.cloudCover,
    this.humidity,
    this.localObsDateTime,
    this.observationTime,
    this.precipInches,
    this.precipMM,
    this.pressure,
    this.pressureInches,
    this.tempC,
    this.tempF,
    this.uvIndex,
    this.visibility,
    this.visibilityMiles,
    this.weatherCode,
    this.weatherDesc,
    this.weatherIconUrl,
    this.winddir16Point,
    this.winddirDegree,
    this.windspeedKmph,
    this.windspeedMiles,
  });

  // Constructor để map từ JSON sang Dart object
  factory CurrentCondition.fromJson(Map<String, dynamic> json) {
    return CurrentCondition(
      feelsLikeC: json['FeelsLikeC'] as String?,
      feelsLikeF: json['FeelsLikeF'] as String?,
      cloudCover: json['cloudCover'] as String?,
      humidity: json['humidity'] as String?,
      localObsDateTime: json['localObsDateTime'] as String?,
      observationTime: json['observation_time'] as String?,
      precipInches: json['precipInches'] as String?,
      precipMM: json['precipMM'] as String?,
      pressure: json['pressure'] as String?,
      pressureInches: json['pressureInches'] as String?,
      tempC: json['temp_C'] as String?,
      tempF: json['temp_F'] as String?,
      uvIndex: json['uvIndex'] as String?,
      visibility: json['visibility'] as String?,
      visibilityMiles: json['visibilityMiles'] as String?,
      weatherCode: json['weatherCode'] as String?,
      weatherDesc: (json['weatherDesc'] as List?)
          ?.map((e) => WeatherDesc.fromJson(e as Map<String, dynamic>))
          .toList(),
      weatherIconUrl: (json['weatherIconUrl'] as List?)
          ?.map((e) => WeatherIconUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      winddir16Point: json['winddir16Point'] as String?,
      winddirDegree: json['winddirDegree'] as String?,
      windspeedKmph: json['windspeedKmph'] as String?,
      windspeedMiles: json['windspeedMiles'] as String?,
    );
  }

  // Hàm để map từ Dart object sang JSON
  Map<String, dynamic> toJson() {
    return {
      'FeelsLikeC': feelsLikeC,
      'FeelsLikeF': feelsLikeF,
      'cloudCover': cloudCover,
      'humidity': humidity,
      'localObsDateTime': localObsDateTime,
      'observation_time': observationTime,
      'precipInches': precipInches,
      'precipMM': precipMM,
      'pressure': pressure,
      'pressureInches': pressureInches,
      'temp_C': tempC,
      'temp_F': tempF,
      'uvIndex': uvIndex,
      'visibility': visibility,
      'visibilityMiles': visibilityMiles,
      'weatherCode': weatherCode,
      'weatherDesc': weatherDesc?.map((e) => e.toJson()).toList(),
      'weatherIconUrl': weatherIconUrl?.map((e) => e.toJson()).toList(),
      'winddir16Point': winddir16Point,
      'winddirDegree': winddirDegree,
      'windspeedKmph': windspeedKmph,
      'windspeedMiles': windspeedMiles,
    };
  }
}

class WeatherDesc {
  String? value;

  WeatherDesc({this.value});

  factory WeatherDesc.fromJson(Map<String, dynamic> json) {
    return WeatherDesc(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class WeatherIconUrl {
  String? value;

  WeatherIconUrl({this.value});

  factory WeatherIconUrl.fromJson(Map<String, dynamic> json) {
    return WeatherIconUrl(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}