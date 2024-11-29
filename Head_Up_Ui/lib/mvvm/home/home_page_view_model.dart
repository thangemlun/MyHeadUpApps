import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/environment/app_properties.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/impl/user_service_impl.dart';
import 'package:head_up_ui/views/home_page.dart';
import 'package:head_up_ui/views/loader_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localstorage/localstorage.dart';


class HomePageViewModel extends ChangeNotifier {
  var userService = UserServiceImpl();
  Widget page = LoaderPage();
  final storage = localStorage;

  Future<void> authenticateUser() async {
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    userService.getUserInfo().then((user) async {
      UserInfo userInfo = user;
      String noteId = base64.encode('${userInfo.email}${AppProperties.NOTE_BOX}'.codeUnits);
      String reminderId = base64.encode('${userInfo.email}${AppProperties.REMINDER_BOX}'.codeUnits);
      storage.setItem("NOTE-ID", noteId);
      storage.setItem("REMINDER-ID", reminderId);
      await Hive.openBox(noteId);
      await Hive.openBox(reminderId);
      page = HomePage();
      notifyListeners();
        }).onError((e,trace) {
      print(e.toString());
      page = LoginPage();
      notifyListeners();
    });
  }
}