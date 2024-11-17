import 'dart:convert';

class ProviderLoginRequest {
  late String accessToken;
  late String? avatar;
  late String? name;

  ProviderLoginRequest(this.accessToken, this.avatar, this.name);

  Map<String, dynamic> toMap() => {
    'accessToken' : accessToken,
    'avatar' : avatar,
    'name' : name
  };

  static String toJson(ProviderLoginRequest request) {
  	return jsonEncode(request.toMap());
  }
}