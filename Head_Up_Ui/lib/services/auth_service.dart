import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:head_up_ui/config/google_provider_config.dart';
import 'package:head_up_ui/environment/app_constant.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/model/login_model.dart';
import 'package:head_up_ui/mvvm/home/home_page_view.dart';
import 'package:head_up_ui/request/login_request.dart';
import 'package:head_up_ui/request/provider_login_request.dart';
import 'package:head_up_ui/response/response.dart';
import 'package:head_up_ui/util/http_util.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:head_up_ui/views/home_page.dart';
import 'package:head_up_ui/views/spinner.dart';
import 'package:toastification/toastification.dart';

class AuthService {
  static const String AuthApi = "/api/auth";

  Future<LoginModel> signInWithGoogle() async {
    final GoogleSignInAccount? ggUser =
        await GoogleProviderUtil.getInstance()?.googleSignIn.signIn();
    GoogleSignInAuthentication ggAuthen = await ggUser!.authentication;
    return await LoginModel.fromGGAuthen(ggUser, ggAuthen);
  }

  Future<void> getTokenGoogleSignIn(BuildContext context) async {
    try {
      Spinner.trigger(context);
      LoginModel login = await this.signInWithGoogle();
      ProviderLoginRequest request =
          ProviderLoginRequest(login.accessToken, login.avatar, login.name);

      String token = request.accessToken ?? "";
      ToastificationUtil.toast(
          "Login successful !", ToastificationType.success);
      TokenSession.getInstance()
          .saveToken(token, AppConstant.EXTERNAL_SERVICE, AppConstant.GOOGLE);

      Spinner.off(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePageView()));
    } catch (e) {
      Spinner.off(context);
      print("Error signing in with Google: $e");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  Future<void> getTokenSignIn(
      BuildContext context, Map<String, dynamic> formMap) async {
    try {
      LoginRequest request = LoginRequest.fromMap(formMap);
      Response rsp;
      Spinner.trigger(context);
      HttpUtil<String>().post(AppConstant.HeadUpBeHost + AuthApi,
          body: LoginRequest.toJson(request),
          headers: {
            'Content-Type': 'application/json',
            // Specify the type of data being sent
          }).then((value) {
        rsp = value;
        ToastificationUtil.toast(
            rsp.message, ToastificationType.success);
        String token = String.fromCharCodes(base64.decode(rsp.data as String));
        TokenSession.getInstance()
            .saveToken(token, AppConstant.JWT_AUTH, "Default");
        Spinner.off(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePageView()));
      }).onError((e, handler) {
        print(e);
        Spinner.off(context);
        ToastificationUtil.toast("Server not available",
            ToastificationType.error);
      });
      ;
    } catch (e) {
      Spinner.off(context);
      print("Error get token from Server: $e");
    }
  }

  Future<void> signOut() async {
    try {
      TokenSession.getInstance().removeToken();
    } catch (e) {}
  }
}
