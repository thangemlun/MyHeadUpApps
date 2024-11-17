import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/model/user_info.dart';

abstract class UserService{

  Future<UserInfo> getUserInfo();

  Future<void> updateUserInfo(BuildContext context, Map<String, dynamic> request);

}