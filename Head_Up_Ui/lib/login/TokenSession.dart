import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

class TokenSession {
  static TokenSession? _instance;

  TokenSession._internal();

  static TokenSession getInstance() {
    if (_instance == null) {
      _instance = TokenSession._internal();
    }
    return _instance!;
  }

  final storage = localStorage;

// Lưu session token
  Future<void> saveToken(String token, String grantedMode, String authenticateSource) async {
     storage.setItem('userToken', token);
     storage.setItem('grantedMode', grantedMode);
     storage.setItem('authenticateSource', authenticateSource);
  }

// Lấy session token
  Future<String?> getToken() async {
    return storage.getItem('userToken');
  }

  Future<String?> getGrantedMode() async {
    return storage.getItem('grantedMode');
  }

  Future<String?> getAuthenticateSource() async {
    return storage.getItem('authenticateSource');
  }

// Xóa session token khi logout
  Future<void> removeToken() async {
    storage.removeItem('userToken');
    storage.removeItem('grantedMode');
    storage.removeItem('authenticateSource');
  }
}