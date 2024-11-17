import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/login/login_page.dart';
import 'package:head_up_ui/mvvm/home/home_page_view.dart';
import 'package:head_up_ui/services/abstract_user_service.dart';
import 'package:head_up_ui/services/auth_service.dart';
import 'package:head_up_ui/services/impl/user_service_impl.dart';
import 'package:head_up_ui/views/home_page.dart';
import 'package:head_up_ui/views/loader_page.dart';

class InitializePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => InitializePageState();
}

class InitializePageState extends State<InitializePage> {

  final authService = AuthService();

  final userService = UserServiceImpl();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return HomePageView();
  }
}