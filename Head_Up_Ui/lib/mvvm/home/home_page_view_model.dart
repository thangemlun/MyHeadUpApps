import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/services/impl/user_service_impl.dart';
import 'package:head_up_ui/views/home_page.dart';
import 'package:head_up_ui/views/loader_page.dart';

class HomePageViewModel extends ChangeNotifier {
  var userService = UserServiceImpl();
  Widget page = LoaderPage();

  Future<void> authenticateUser() async {
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    userService.getUserInfo().then((user) {
      if (user != null) {
        page = HomePage();
        notifyListeners();
      }
    }).onError((e,trace) {
      page = LoginPage();
      notifyListeners();
    });
  }
}