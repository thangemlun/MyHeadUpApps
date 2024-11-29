import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:head_up_ui/login/TokenSession.dart';
import 'package:head_up_ui/model/user_info.dart';
import 'package:head_up_ui/services/abstract_user_service.dart';
import 'package:head_up_ui/services/impl/user_service_impl.dart';
import 'package:meta/meta.dart';

part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final eventController = StreamController<UserInfoEvent>();
  final stateController = StreamController<UserInfoState>();
  final UserService userService = new UserServiceImpl();

  UserInfoBloc() : super(UserInfoInitial()) {
    on<UserInfoEvent>((event, emit) async {
      switch(event) {
        case GetUserInfoEvent():
          emit(UserInfoInitial());
          UserInfo userInfo = await userService.getUserInfo();
          await Future.delayed(Duration(seconds: 2));
          emit(LoadUserState(userInfo));
        case LoadUserEvent():
          emit(UserInfoInitial());
      }
    });
  }
}
