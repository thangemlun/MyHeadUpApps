import 'dart:convert';
import 'package:head_up_ui/enum/http_method.dart';
import 'package:head_up_ui/environment/app_constant.dart';
import 'package:head_up_ui/exception/http_custom_exception.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class HttpUtil<T> {
  static var HEADERS = {
    'Content-Type': 'application/json',
    'Authorization': ''
  };

  // post
  Future<Response> post(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    return await execute(HttpMethod.POST, url,
        body: body, headers: headers, encoding: encoding);
  }

  // get
  Future<Response> get(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    return await execute(HttpMethod.GET, url, headers: headers);
  }

  // put
  Future<Response> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var headers = await getHeaderWithToken();
    return await execute(HttpMethod.PUT, url,
        body: body, headers: headers, encoding: encoding);
  }

  Future<Map<String, String>> getHeaderWithToken() async {
    Map<String, String> headers = HttpUtil.HEADERS;
    String? token = await TokenSession.getInstance().getToken();
    String grantedMode =
        await TokenSession.getInstance().getGrantedMode() ?? "";
    String authenticationSource =
        await TokenSession.getInstance().getAuthenticateSource() ?? "";
    headers['Authorization'] = 'Bearer ${token}';
    headers[AppConstant.AUTHORIZATION_GRANTED_MODE] = grantedMode;
    headers[AppConstant.AUTHORIZATION_EXTERNAL_SYSTEM] = authenticationSource;
    return headers;
  }

  static Future<Response> execute(HttpMethod method, String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    http.Response resp = http.Response("No data", 200);
    Response rspBody = Response(true, "No data");
    switch (method) {
      case HttpMethod.GET:
        resp = await http.get(Uri.parse(url), headers: headers);
        rspBody = Response.fromJson(jsonDecode(resp.body));
        break;
      case HttpMethod.POST:
        resp = await http.post(Uri.parse(url),
            body: body, headers: headers, encoding: encoding);
        rspBody = Response.fromJson(jsonDecode(resp.body));
        break;
      case HttpMethod.PUT:
        resp = await http.put(Uri.parse(url), body: body, headers: headers);
        rspBody = Response.fromJson(jsonDecode(resp.body));
        break;
      case HttpMethod.DELETE:
        resp = await http.delete(Uri.parse(url), body: body, headers: headers);
        rspBody = Response.fromJson(jsonDecode(resp.body));
        break;
    }
    if (resp.statusCode != 200) {
      throw HttpCustomException(rspBody.message);
    }
    return rspBody;
  }
}
