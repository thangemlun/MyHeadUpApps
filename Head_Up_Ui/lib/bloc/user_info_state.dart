part of 'user_info_bloc.dart';

@immutable
sealed class UserInfoState {
}

final class UserInfoInitial extends UserInfoState {
  UserInfoInitial();
}

final class LoadUserState extends UserInfoState {
  final UserInfo userInfo;
  LoadUserState(this.userInfo);
}
