import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/environment/app_constant.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/services/abstract_user_service.dart';
import 'package:head_up_ui/util/http_util.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:head_up_ui/views/spinner.dart';
import 'package:toastification/toastification.dart';

class UserServiceImpl extends UserService {

  static const String USER_API = "/api/user";

  @override
  Future<UserInfo> getUserInfo() async {
    // TODO: implement getUserInfo
    Response? response;
    response = (await HttpUtil<UserInfo>().get("${AppConstant.HeadUpBeHost + USER_API}/user-info")) as Response?;
    return UserInfo.fromJson(response!.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateUserInfo(BuildContext context, Map<String, dynamic> request) async {
    // TODO: implement updateUserInfo
    Response resp;
    String api = '${AppConstant.HeadUpBeHost + USER_API}/update';
    Spinner.trigger(context);
    resp = await HttpUtil<UserInfo>().put(api, body: jsonEncode(request));
    ToastificationUtil.toast(resp.message, ToastificationType.success, Alignment.topRight);
    Spinner.off(context);
  }

}