part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoEvent {
  UserInfoEvent();
}

class GetUserInfoEvent extends UserInfoEvent {
  GetUserInfoEvent();
}

class LoadUserEvent extends UserInfoEvent {
  LoadUserEvent();
}
