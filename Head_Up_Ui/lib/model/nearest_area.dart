class NearestArea {

  static final sampleData = NearestArea(
    areaName: List.of([AreaName(value: "Ho Chi Minh City")]),
    country: List.of([Country(value: "Vietnam")]),
    longitude: "10.750",
    latitude: "106.667",
    population: "3467426",
  );

  List<AreaName>? areaName;
  List<Country>? country;
  String? latitude;
  String? longitude;
  String? population;
  List<Region>? region;
  List<WeatherUrl>? weatherUrl;

  NearestArea({
    this.areaName,
    this.country,
    this.latitude,
    this.longitude,
    this.population,
    this.region,
    this.weatherUrl,
  });

  // Các hàm khởi tạo từ JSON và chuyển về JSON nếu cần
  factory NearestArea.fromJson(Map<String, dynamic> json) {
    return NearestArea(
      areaName: (json['areaName'] as List<dynamic>?)
          ?.map((e) => AreaName.fromJson(e as Map<String, dynamic>))
          .toList(),
      country: (json['country'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      population: json['population'] as String?,
      region: (json['region'] as List<dynamic>?)
          ?.map((e) => Region.fromJson(e as Map<String, dynamic>))
          .toList(),
      weatherUrl: (json['weatherUrl'] as List<dynamic>?)
          ?.map((e) => WeatherUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'areaName': areaName?.map((e) => e.toJson()).toList(),
      'country': country?.map((e) => e.toJson()).toList(),
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
      'region': region?.map((e) => e.toJson()).toList(),
      'weatherUrl': weatherUrl?.map((e) => e.toJson()).toList(),
    };
  }
}

class AreaName {
  String? value;

  AreaName({this.value});

  factory AreaName.fromJson(Map<String, dynamic> json) {
    return AreaName(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class Country {
  String? value;

  Country({this.value});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class Region {
  String? value;

  Region({this.value});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}

class WeatherUrl {
  String? value;

  WeatherUrl({this.value});

  factory WeatherUrl.fromJson(Map<String, dynamic> json) {
    return WeatherUrl(
      value: json['value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
    };
  }
}
