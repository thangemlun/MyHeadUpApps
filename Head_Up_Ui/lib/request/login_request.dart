import 'dart:convert';

class LoginRequest {
  late String? email;
  late String? password;

  LoginRequest({this.email, this.password});

  LoginRequest.fromMap(Map<String, dynamic> dataMap) : this(
    email: dataMap["email"],
    password: dataMap["password"]
  );

  Map<String, dynamic> toMap() => {
    'email' : email,
    'password' : password
  };

  static String toJson(LoginRequest request) {
    return jsonEncode(request.toMap());
  }

}