import 'dart:convert';
import 'package:head_up_ui/environment/app_constant.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
class HttpUtil<T>{
  static var HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': ''
  };

	// post
  Future<Response> post(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    http.Response resp = await http.post(
      Uri.parse(url), body: body, headers: headers, encoding: encoding
    );
    Response rsp = Response.fromJson(jsonDecode(resp.body));
    return rsp;
  }

  // get
  Future<Response> get(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    http.Response resp = await http.get(Uri.parse(url), headers: headers);
    Response rsp = Response.fromJson(jsonDecode(resp.body));
    return rsp;
  }

  // put
  Future<Response> put(String url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    http.Response resp = await http.put(Uri.parse(url),body: body, headers: headers);
    Response rsp = Response.fromJson(jsonDecode(resp.body));
    return rsp;
  }

  Future<Map<String, String>> getHeaderWithToken() async {
    Map<String, String> headers = HttpUtil.HEADERS;
    String? token = await TokenSession.getInstance().getToken();
    String grantedMode = await TokenSession.getInstance().getGrantedMode() ?? "";
    String authenticationSource = await TokenSession.getInstance().getAuthenticateSource() ?? "";
    headers['Authorization'] = 'Bearer ${token}';
    headers[AppConstant.AUTHORIZATION_GRANTED_MODE] = grantedMode;
    headers[AppConstant.AUTHORIZATION_EXTERNAL_SYSTEM] = authenticationSource;
    return headers;
  }
}