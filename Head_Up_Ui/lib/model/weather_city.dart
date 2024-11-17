class WeatherCity {
  String? city;
  double? lat;
  double? lon;
  String? country;
  String? countryCode;

  WeatherCity({
    this.city,
    this.lat,
    this.lon,
    this.country,
    this.countryCode,
  });

  // Factory constructor để tạo object từ JSON
  factory WeatherCity.fromJson(Map<String, dynamic> json) {
    return WeatherCity(
      city: json['city'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
    );
  }

  // Phương thức chuyển object thành JSON
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'lat': lat,
      'lon': lon,
      'country': country,
      'countryCode': countryCode,
    };
  }
}
